//
//  main.swift
//  MyCreditManager
//
//  Created by heyji on 2022/11/15.
//

import Foundation

var students: [String] = []
var score: [String: [String]] = [:]
var input = ""

repeat {
    print("원하는 기능을 입력해주세요 \n 1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let inputValue = readLine()
    input = inputValue ?? ""

    if input == "1" {
        print("추가할 학생의 이름을 입력해주세요")
        let inputName = readLine()!
        if students.isEmpty {
            print("\(inputName) 학생을 추가했습니다.")
            students.append(inputName)
        } else {
            for i in students {
                if inputName == i {
                    print("\(inputName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                    break
                }
                print("\(inputName) 학생을 추가했습니다.")
                students.append(inputName)
            }
        }
        
    } else if input == "2" {
        print("삭제할 학생의 이름을 입력해주세요")
        let inputDeleteName = readLine()!
        
        if (students.firstIndex(of: inputDeleteName) != nil) {
            print("\(inputDeleteName) 학생을 삭제하였습니다")
            let index = students.firstIndex(of: inputDeleteName)
            students.remove(at: Int(index!))
        } else {
            print("\(inputDeleteName) 학생을 찾지 못했습니다")
        }
        
    } else if input == "3" {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요. \n 입력예) Mickey Swift A+ \n 만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let inputScore = readLine()?.components(separatedBy: " ")
        if inputScore?.count == 3 {
            let value = "\(inputScore![1]): \(inputScore![2])"
            if score.index(forKey: inputScore![0]) != nil {
                var currentValue = score[inputScore![0]]!
                for i in currentValue {
                    let subjectName = i.components(separatedBy: ":")
                    if subjectName[0] == inputScore![1] {
                        let index = currentValue.firstIndex(of: i)
                        currentValue[index!] = value
                    } else {
                        currentValue.append(value)
                    }
                }
                score.updateValue(currentValue, forKey: inputScore![0])
            } else {
                score.updateValue([value], forKey: inputScore![0])
            }
            print("\(inputScore![0]) 학생의 \(inputScore![1]) 과목이 \(inputScore![2])로 추가(변경)되었습니다.")
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        
    } else if input == "4" {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요. \n 입력예) Mickey Swift")
        let inputDeleteScore = readLine()?.components(separatedBy: " ")
        if inputDeleteScore?.count == 2 {
            if score.index(forKey: inputDeleteScore![0]) != nil {
                var value = score[inputDeleteScore![0]]!
                var firstIndex: Int = 0
                for i in value {
                    let subjectName = i.components(separatedBy: ":")
                    if subjectName[0] == inputDeleteScore![1] {
                        firstIndex = value.firstIndex(of: i)!
                    }
                }
                value.remove(at: firstIndex)
                score.updateValue(value, forKey: inputDeleteScore![0])
                print("\(inputDeleteScore![0]) 학생의 \(inputDeleteScore![1]) 과목의 성적이 삭제되었습니다.")
            } else {
                print("\(inputDeleteScore![0]) 학생을 찾지 못했습니다.")
            }
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
        
    } else if input == "5" {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        let inputName = readLine()!
        if score.index(forKey: inputName) != nil {
            let value = score[inputName]!
            let count: Double = Double(value.count)
            var sum: Double = 0.0
            for i in value {
                print(i)
                let score = i.components(separatedBy: " ")
                switch score[1] {
                case "A+":
                    print(4.5)
                    sum += 4.5
                case "A":
                    print(4)
                    sum += 4
                case "B+":
                    print(3.5)
                    sum += 3.5
                case "B":
                    print(3)
                    sum += 3
                case "C+":
                    print(2.5)
                    sum += 2.5
                case "C":
                    print(2)
                    sum += 2
                case "D+":
                    print(1.5)
                    sum += 1.5
                case "D":
                    print(1)
                    sum += 1
                case "F":
                    print(0)
                    sum += 0
                default:
                    ()
                }
            }
            let average = sum / count
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 2
            let score = numberFormatter.string(for: average) ?? "0"
            print("평점: \(score)")
            
        } else {
            print("\(inputName) 학생을 찾지 못했습니다.")
        }
        
    } else if input == "X" {
        print("프로그램을 종료합니다...")
    } else {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
} while input != "X"
