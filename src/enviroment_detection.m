function [noiseSpec, modeName] = environment_detection(fs, frameSize, noiseFrames)

deviceReader = audioDeviceReader('SampleRate', fs, 'SamplesPerFrame', frameSize);
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

noiseSpec = (noiseSpecTemp / noiseFrames) * modeFactor;
end
