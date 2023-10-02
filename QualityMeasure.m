function [brisqueScore,niqeScore, piqeScore] = QualityMeasure(img)
% score = brisque(A) 
% calculates the no-reference image quality score 
% for image A using the Blind/Referenceless Image Spatial Quality Evaluator (BRISQUE). 
% brisque compare A to a default model computed from images of natural scenes with similar distortions.
% A smaller score indicates better perceptual quality.
brisqueScore = brisque(img);

% score = niqe(A) calculates the no-reference image quality score for image A using the Naturalness Image Quality Evaluator (NIQE).
% niqe compares A to a default model computed from images of natural scenes.
% A smaller score indicates better perceptual quality.
niqeScore = niqe(img);

% score = piqe(A) calculates the no-reference image quality score for image A using a perception based image quality evaluator. 
% A smaller score indicates better perceptual quality.
piqeScore = piqe(img);


end

