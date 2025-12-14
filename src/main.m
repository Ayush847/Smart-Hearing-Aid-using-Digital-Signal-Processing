fs = 20000;
frameSize = 1024;
noiseFrames = 400;
maxDuration = 12;

[noiseSpec, modeName] = environment_detection(fs, frameSize, noiseFrames);
disp(['Environment detected: ', modeName]);

[mainAudio, filteredAudio] = spectral_processing(fs, frameSize, maxDuration, noiseSpec);

audiowrite('audio_samples/output/main_audio.wav', mainAudio, fs);
audiowrite('audio_samples/output/filtered_audio.wav', filteredAudio, fs);
