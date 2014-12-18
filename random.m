function[interaction]=random(matrix)
    interaction = matrix;
    nC = length(matrix);
    inRow = randperm(nC);
    interaction(inRow(1:round(length(inRow)/2)),inRow(1:round(length(inRow)/2))) = -1;
end