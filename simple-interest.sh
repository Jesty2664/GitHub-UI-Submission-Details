#!/bin/bash

# Function to safely read and validate a number
read_number() {
    local prompt=$1
    local var_name=$2
    local input

    while true; do
        echo -n "$prompt"
        read input
        # Check if input is a valid positive number (integer or decimal)
        if [[ "$input" =~ ^[0-9]+(\.[0-9]+)?$ ]] && (( $(echo "$input > 0" | bc -l) )); then
            # Assign the validated input to the correct variable name
            eval $var_name='$input'
            break
        else
            echo "❌ Invalid input. Please enter a positive number."
        fi
    done
}

echo "--- Simple Interest Calculator ---"

# Prompt with validation
read_number "Enter the principal amount ($): " principal
read_number "Enter the annual interest rate (e.g., 0.05 for 5%): " rate
read_number "Enter the time period (in years): " time

# Use 'bc -l' for floating-point calculation (Simple Interest = P * R * T)
# The '-l' flag loads the math library, necessary for floating point numbers.
interest=$(echo "$principal * $rate * $time" | bc -l)

# Calculate the final Amount (A = P + I)
amount=$(echo "$principal + $interest" | bc -l)

echo "-----------------------------------"
echo "Principal: \$ $principal"
echo "Rate: $rate"
echo "Time (Years): $time"
echo "-----------------------------------"
echo "Simple Interest Earned: \$ $interest"
echo "Total Final Amount: \$ $amount"
echo "-----------------------------------"
