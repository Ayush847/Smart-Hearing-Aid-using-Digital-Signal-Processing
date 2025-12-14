function [mainAudio, filteredAudio] = spectral_processing(fs, frameSize, maxDuration, noiseSpec)

maxSamples = fs * maxDuration;
mainAudio = zeros(maxSamples,1);
filteredAudio = zeros(maxSamples,1);

deviceReader = audioDeviceReader('SampleRate', fs, 'SamplesPerFrame', frameSize);

reductionFactor = 0.7;
gainFloor = 0.15;

sampleIndex = 1;
recording = true;

while recording && (sampleIndex + frameSize - 1) <= maxSamples
    frame = deviceReader();
    frameFFT = fft(frame);

    origMag = abs(frameFFT);
    mag = origMag - reductionFactor * noiseSpec;
    mag = max(mag, gainFloor * origMag);

    phase = angle(frameFFT);
    filteredFrame = real(ifft(mag .* exp(1i * phase)));

    mainAudio(sampleIndex:sampleIndex+frameSize-1) = frame;
    filteredAudio(sampleIndex:sampleIndex+frameSize-1) = filteredFrame;

    sampleIndex = sampleIndex + frameSize;

    if mod(sampleIndex, fs*5) == 1
        str = input('Type K then Enter to stop ', 's');
        if strcmpi(str, 'K')
            recording = false;
        end
    end
end

mainAudio = mainAudio(1:sampleIndex-1);
filteredAudio = filteredAudio(1:sampleIndex-1);
end
