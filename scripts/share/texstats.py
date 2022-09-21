#!/usr/bin/env python
import sys
import json

def print_task(file,series,taskNumber,points,averagePoints,solversCount):
    file.write("{};{};{};{};{}\n".format(series,taskNumber,points,averagePoints,solversCount))

def process_data():
    if len(sys.argv) < 4:
        print("Usage: python texstats.py <series> <input-file> <output-file>")
        print("Data from <input-file> in JSON format are parsed and outputed")
        print("to <output-file> as CSV.")
        return

    series=int(sys.argv[1])
    inputFileName=sys.argv[2]
    outputFileName=sys.argv[3]

    with open(inputFileName,'r') as file:
        data = json.load(file)

    outputFile = open(outputFileName,'w+')

    for task in data:
        if task['series'] == series:
            # Format averagePoints and catch null values
            averagePoints = task['averagePoints']
            if averagePoints is None:
                averagePoints = "NaN"
            else:
                averagePoints = "{:.2f}".format(averagePoints).replace('.',',')

            print_task(outputFile, task['series'], task['taskNumber'],task['points'],
                       averagePoints, task['solversCount'])
    outputFile.close()

if __name__ == "__main__":
    process_data()
