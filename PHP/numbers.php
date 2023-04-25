<?php
// PART ONE
function decimalToBinary($decimal) {
    return decbin($decimal);
}

function decimalToRoman($decimal) {
    if ($decimal > 3999999) {
        echo "Error: Decimal number $decimal is greater than 3999999.\n";
        return;
    }

    $romanNumeral = '';
    $romanNumerals = array(
        'M' => 1000,
        'CM' => 900,
        'D' => 500,
        'CD' => 400,
        'C' => 100,
        'XC' => 90,
        'L' => 50,
        'XL' => 40,
        'X' => 10,
        'IX' => 9,
        'V' => 5,
        'IV' => 4,
        'I' => 1
    );

    foreach ($romanNumerals as $romanNumeralSymbol => $value) {
        while ($decimal >= $value) {
            $romanNumeral .= $romanNumeralSymbol;
            $decimal -= $value;
        }
    }

    return $romanNumeral;
}


//PART TWO


function binaryToDecimal($binary) {
    return bindec($binary);
}

function romanToDecimal($roman) {
    $decimal = 0;
    $romanNumerals = array(
        'M' => 1000,
        'CM' => 900,
        'D' => 500,
        'CD' => 400,
        'C' => 100,
        'XC' => 90,
        'L' => 50,
        'XL' => 40,
        'X' => 10,
        'IX' => 9,
        'V' => 5,
        'IV' => 4,
        'I' => 1
    );

    for ($i = 0; $i < strlen($roman); $i++) {
        $currentSymbolValue = $romanNumerals[$roman[$i]];
        $nextSymbolValue = isset($roman[$i+1]) ? $romanNumerals[$roman[$i+1]] : 0;

        if ($currentSymbolValue < $nextSymbolValue) {
            $decimal -= $currentSymbolValue;
        } else {
            $decimal += $currentSymbolValue;
        }
    }

    return $decimal;
}


// PART THREE
function isRoman($romanNumberArgument) {
    $roman_regex='/^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/';
    return preg_match($roman_regex, $romanNumberArgument) > 0;
}

/**
 * Function that checks wheater the number is decimal.
 */
function isDecimal($numberArgument) {
    if (is_float($numberArgument)) {
        return true;
    }
}

/**
 * Function that checks wheater the number is binary.
 */
function isBinary($numberArgument) {
    if (substr($numberArgument, 0, 0) === "+" || substr($numberArgument, 0, 0) === "-") {
        echo "Binary number shouldn't contain signs such as '+' / '-'";
        return false;
    }
    $binary_regex = "/^[0-1]+$/";
    if(preg_match($binary_regex, $numberArgument)) { 
        return true;
    }
}

/**
 * Function that checks is number is roman, decimal, decade  or binary.
 */
function checkNumber($number) {
    if (substr($number, 0, 1) === "0" || substr($number, 1, 1) === "0" && (substr($number, 0, 1) === "+" || substr($number, 0, 1) === "-")) {
        return "Error (eg. +0123) - unsupported format";
    } else if (isRoman($number)) {
        return "The number[{$number}] is Roman number..
        <br/>Roman to Decimal => " . romanToDecimal($number) . "<br/>";
    } else if (isDecimal($number)) {
        return "The number[{$number}] is Decimal number.. 
        <br/>Decimal to Roman => " . decimalToRoman($number, 3999999) . "<br/>
        Decimal to Binary => " . decimalToBinary($number) . "<br/>";
    } else if (isBinary($number)) {
        return "The number[{$number}] is Binary number..
        <br/>Binary to Decimal => " . binaryToDecimal($number) . "<br/>";
    } 

    $binary_regex = "/^[-+0-1]+$/";
    if(preg_match($binary_regex, $number)) { 
        if ($number >= 100 || $number <= 0) {
            return "The number[{$number}] is Decade number..
            <br/>Decade to Binary => " . decimalToBinary($number) . "<br/>
            Decade to Roman => " . decimalToRoman($number, 3999999) . "<br/>";
        }
        return "Invalid! The number[{$number}] contains sign and zeroes & ones only..";
    }
    return "The number[{$number}] is Decade number..
    <br/>Decade to Binary => " . decimalToBinary($number) . "<br/>
    Decade to Roman => " . decimalToRoman($number, 3999999) . "<br/>";
}

$arr = [ +2023.1, "X", "111", +7.08, "D", "10101" ];
foreach($arr as $number){
    echo checkNumber($number). "<br/>";
}
?>