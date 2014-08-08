# Functions for Chain Ladder Analysis in Julia

function GetFactor(index, mTri)
	nRow::Int = size(mTri)[1] - index
	mTri = mTri[1:nRow, index:(index + 1)]
	mTri = sum(mTri, 1)
	return mTri[2]/mTri[1]
end
	

function GetChainSquare(mTri)
	nCol = size(mTri)[2]
	dFactors = [GetFactor(i, mTri) for i = 1:(nCol - 1)]
	dAntiDiag = diag(mTri[:, reverse(1:nCol)])[2:nCol]
	for index = 1:length(dAntiDiag)
		mTri[index + 1, (nCol - index + 1):nCol] = dAntiDiag[index]*cumprod(dFactors[(nCol - index):(nCol - 1)])
	end
	mTri
end

# Faster using single insertion
function GetChainSquare2(mTri)
	nCol = size(mTri)[2]
	dFactors = [GetFactor(i, mTri) for i = 1:(nCol - 1)]
	dAntiDiag = diag(mTri[:, reverse(1:nCol)])
	dFac = []
	for i = 2:nCol
		nFac = dFactors[nCol - i + 1]
		dFac = append!([nFac], nFac*dFac)
		for j = (nCol - i + 2):nCol
			mTri[i, j] = dAntiDiag[i]*dFac[i + j - (nCol + 1)]
		end
	end
	return mTri
end
