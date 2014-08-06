# Julia code for Chain Ladder Analysis with DataArrays

using DataArrays, DataFrames

function GetFactor(index, mTri)
	nRow::Int = size(mTri)[1] - index
	mTri = mTri[1:nRow, index:(index + 1)]
	mTri = sum(mTri, 1)
	return mTri[2]/mTri[1]
end
	

function GetChainSquare(mTri)
	nRow = size(mTri)[1]
	nCol = size(mTri)[2]
	dFactors = [GetFactor(i, mTri) for i = 1:(nCol - 1)]
	dAntiDiag = diag(mTri[:, reverse(1:nRow)])[2:nCol]
	for index = 1:length(dAntiDiag)
		mTri[index + 1, (nCol - index + 1):nCol] = dAntiDiag[index]*cumprod(dFactors[(nCol - index):(nCol - 1)])
	end
	mTri
end
