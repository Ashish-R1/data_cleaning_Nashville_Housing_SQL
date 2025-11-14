Use Portfolio_proj

SELECT SaleDate, CONVERT(Date, SaleDate)
FROM Portfolio_proj.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

SELECT SaleDateConverted, CONVERT(Date, SaleDate)
FROM Portfolio_proj.dbo.NashvilleHousing

 --------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data

SELECT *
FROM Portfolio_proj.dbo.NashvilleHousing
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress ,b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolio_proj.dbo.NashvilleHousing a
Join Portfolio_proj.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Portfolio_proj.dbo.NashvilleHousing a
Join Portfolio_proj.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null

-- Breaking out Address into Individual Columns (Address, City, State)

SELECT PropertyAddress
FROM Portfolio_proj.dbo.NashvilleHousing


SELECT 
SUBSTRING ( PropertyAddress, 1, CHARINDEX (',', PropertyAddress) -1 ) AS Address,
SUBSTRING ( PropertyAddress, CHARINDEX (',', PropertyAddress) +1, LEN(PropertyAddress) ) AS Address
FROM Portfolio_proj.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING ( PropertyAddress, 1, CHARINDEX (',', PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING ( PropertyAddress, CHARINDEX (',', PropertyAddress) +1, LEN(PropertyAddress) )

SELECT *
FROM Portfolio_proj.dbo.NashvilleHousing

SELECT OwnerAddress
FROM Portfolio_proj.dbo.NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM Portfolio_proj.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)


ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

SELECT *
FROM Portfolio_proj.dbo.NashvilleHousing

-- Change Y and N to Yes and No in "Sold as Vacant" field
SELECT DISTINCT(SoldAsVacant), count(SoldAsVacant)
FROM Portfolio_proj.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END
FROM Portfolio_proj.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END

-- Remove Duplicates

WITH RowNumCTE AS (
SELECT 
	*,
	ROW_NUMBER() OVER(
		PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
		ORDER BY
			UniqueID
	)row_num
FROM Portfolio_proj.dbo.NashvilleHousing
)

DELETE
FROM RowNumCTE
WHERE row_num > 1

-- Delete Unused Columns

ALTER TABLE Portfolio_proj.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
