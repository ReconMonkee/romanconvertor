def fromRoman(romanNumber)
    romanNumerals =["I","V","X","L","C","D","M"]
    lastVal = 0
    for numerals in romanNumber.chars
        if !romanNumerals.include? numerals
            raise TypeError
        end
    end
    mVal, i = charLoop("M", romanNumber, 1000)
    cVal, i = charLoop("C", romanNumber, 100, i)
    xVal, i = charLoop("X", romanNumber, 10, i)
    iVal, i = charLoop("I", romanNumber, 1, i)
    return lastVal = mVal + cVal + xVal + iVal
end

def charLoop(letterTier, romanNumber, val, i = 0)
    endVal = 0
    half = split(letterTier)
    nextCheck = getNext(letterTier)
    if romanNumber[i] != letterTier
        endVal = val*5
        i += 1
    else
        return endVal, i
    end

    for numerals in romanNumber.chars[i..romanNumber.chars.length - 1]
        if numerals == letterTier
            endVal += val
            i += 1
        elsif numerals == half
            endVal += val*3
            i += 1
        elsif numerals == nextCheck
            endVal += val*8
            i += 1
            break
        end
    end
    return endVal, i
end

def split(numerals)
    half = ""
    if numerals == "C"
        half = "D"
    elsif numerals == "X"
        half = "L"
    elsif numerals == "I"
        half = "V"
    end
    return half
end

def getNext(numerals)
    nextCheck = ""
    if numerals == "C"
        nextCheck = "M"
    elsif numerals == "X"
        nextCheck = "C"
    elsif numerals == "I"
        nextCheck = "X"
    end
    return nextCheck
end

def toRoman(arabicNumber)
    romanNumber = ""
    if arabicNumber>3999 || arabicNumber <=0
        raise RangeError
    end
    numM = arabicNumber/1000.00
    numC = (arabicNumber - numM.floor * 1000.00) /100.00
    numX = (numC * 100.00 - numC.floor * 100.00) /10.00
    numI = numX * 10.00 - (numX.floor * 10.00)
    romanNumber = "M" * numM.floor
    updatedRomanNumber = romanNumber + splitCheck(numC,"C")
    updatedRomanNumber = updatedRomanNumber + splitCheck(numX,"X")
    updatedRomanNumber = updatedRomanNumber + splitCheck(numI,"I")
    return updatedRomanNumber
end

def splitCheck(numChar, character)
    numChar = numChar.floor
    half = split(character)
    nextCheck = getNext(character)
    if numChar < 4
        return character * numChar
    end
    if numChar == 4
        return character + half
    elsif numChar == 9
        return character + nextCheck
    else
        return half + character * (numChar-5)
    end
end