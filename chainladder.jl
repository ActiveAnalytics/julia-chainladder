# Functions for Chain Ladder Analysis in Julia

function GetFactor(index, mTri)
	nRow::Int = size(mTri)[1] - index
	mTri = mTri[1:nRow, index:(index + 1)]
	mTri = sum(mTri, 1)
	return mTri[2]/mTri[1]
end
	

function GetChainSquare(mTri)
	mTri = mTri[:, :] # copy matrix so as not to overwrite
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
	mTri = mTri[:, :] # copy matrix so as not to overwrite
	p = size(mTri)[2] # This is the size of the triangle
	dFactors = [GetFactor(i, mTri) for i = 1:(p - 1)] # the chain ladder factors
	for i = 2:p # iterate over the rows
		for j = (p - i + 2):p # iterative over the columns from the "antidiagonal"
			mTri[i, j] = mTri[i, j-1]*dFactors[j - 1]
		end
	end
	return mTri
end
