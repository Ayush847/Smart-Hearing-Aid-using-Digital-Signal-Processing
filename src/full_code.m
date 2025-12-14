fs = 20000;
frameSize = 1024;
noiseFrames = 400;
maxDuration = 12;
maxSamples = maxDuration * fs;

mainAudio = zeros(maxSamples,1);
filteredAudio = zeros(maxSamples,1);

deviceReader = audioDeviceReader('SampleRate', fs, 'SamplesPerFrame', frameSize);

disp('Detecting environment automatically...');
noiseSpecTemp = zeros(frameSize,1);

for i = 1:noiseFrames
    frame = deviceReader();
    frameFFT = fft(frame);
    noiseSpecTemp = noiseSpecTemp + abs(frameFFT);
end

avgNoiseLevel = mean(noiseSpecTemp / noiseFrames);

if avgNoiseLevel < 0.02
    modeName = 'Room';
    modeFactor = 1.0;
elseif avgNoiseLevel < 0.05
    modeName = 'Hall';
    modeFactor = 1.5;
elseif avgNoiseLevel < 0.1
    modeName = 'Roadside';
    modeFactor = 2.0;
else
    modeName = 'Traffic';
    modeFactor = 3.0;
end

disp(['Environment detected: ', modeName]);
noiseSpec = (noiseSpecTemp / noiseFrames) * modeFactor;
disp('Noise estimation complete. Start speaking!');

recording = true;
sampleIndex = 1;

reductionFactor = 0.7;
gainFloor = 0.15;

while recording && (sampleIndex + frameSize - 1) <= maxSamples
    frame = deviceReader();
    frameFFT = fft(frame);
    
    origMag = abs(frameFFT);
    mag = origMag - reductionFactor * noiseSpec;
    mag = max(mag, gainFloor * origMag);
    
    phase = angle(frameFFT);
    filteredFrame = real(ifft(mag .* exp(1i * phase)));
    
    mainAudio(sampleIndex : sampleIndex+frameSize-1) = frame;
    filteredAudio(sampleIndex : sampleIndex+frameSize-1) = filteredFrame;
    
    sampleIndex = sampleIndex + frameSize;
    
    if mod(sampleIndex, fs*5) == 1
        str = input('Type K then Enter to stop ', 's');
        if strcmpi(str, 'K')
            recording = false;
            disp('Recording stopped.');
        end
    end
end

mainAudio = mainAudio(1:sampleIndex-1);
filteredAudio = filteredAudio(1:sampleIndex-1);

audiowrite('main_audio.wav', mainAudio, fs);
audiowrite('filtered_audio.wav', filteredAudio, fs);
disp('Files saved');

