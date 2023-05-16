//
//  iOSSolvesUtilities.swift
//  iOSSolvesUtilities
//
//  Created by iOS Solves on 16/05/23.
//

import Foundation


/*
 
 let adder = Adder()
 let result1 = adder(1, 2, 3) // calls dynamicallyCall(withArguments:) method
 print(result1) // prints 6

 let result2 = adder(a: 1, b: 2, c: 3) // calls dynamicallyCall(withKeywordArguments:) method
 print(result2) // prints 6
 
 */

@dynamicCallable
public struct Adder {
    
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        return args.reduce(0, +)
    }
    
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Int {
        return args.reduce(0) { $0 + $1.value }
    }
}



/* Kaden's Algorithm */


/*

Given an integer array nums,
 find the contiguous subarray (containing at least one number)
 which has the largest sum and return its sum.
 Ex :[-2, 4,-1,2,1, 1,-3,-5,4]
 
 Ans. Explanation [4,-1,2,1] has the largest sum =6

 let collection = [5,4,-1,7,8]
 let subArrayHavingMaxSum = collection.contiguousSubArrayWithMaxSum(inCollection: collection).contigousSubArray
 let maxSum = collection.contiguousSubArrayWithMaxSum(inCollection: collection).maxSum

 print("\(subArrayHavingMaxSum) = \(maxSum)")
 
 
 */


struct RangeAndBigSum {
    let startIndex: Int
    let endIndex: Int
    let bigSum: Int
}

extension Array where Element== Int {
    
    public func contiguousSubArrayWithMaxSum(inCollection collection: [Int]) -> (contigousSubArray: [Int], maxSum: Int) {
        
        var sumsArr: [RangeAndBigSum] = []
        
        for startIndex in 0..<collection.count {
            let maxSum = maxSum(at: startIndex, inCollection: collection)
            sumsArr.append(maxSum)
        }
        
        sumsArr.sort { $0.bigSum > $1.bigSum } //Refactor
        let rangeAndSum = sumsArr[0]
        
        var startIndex = rangeAndSum.startIndex
        let endIndex = rangeAndSum.endIndex
        let maxContigousSum = rangeAndSum.bigSum
        
        var subArrayHavingMaxSum: [Int] = []
        
        while startIndex <= endIndex { //Refactor
            subArrayHavingMaxSum.append(collection[startIndex])
            startIndex += 1
        }
        
        return (subArrayHavingMaxSum, maxContigousSum)
    }
    
    private func maxSum(at startIndex: Int, inCollection collection: [Int]) -> RangeAndBigSum {
        
        var sum = collection[startIndex]
        var bigSum = 0
        var endIndex = 0
        var i = startIndex
        let collectionLength = collection.count
        
        while i < collectionLength { //Refactor
            let nextIndex = i + 1
            if nextIndex != collectionLength {
                sum += collection[nextIndex]
                if sum > bigSum {
                    bigSum = sum
                    endIndex = nextIndex
                }
            }
            
            i += 1
            
        }
        
        return RangeAndBigSum(startIndex: startIndex, endIndex: endIndex, bigSum: bigSum)
    }
}




