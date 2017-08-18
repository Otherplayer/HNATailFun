//
//  SwiftController.swift
//  APPLEKnowledgeRecorder
//
//  Created by __无邪_ on 2017/7/12.
//  Copyright © 2017年 __无邪_. All rights reserved.
//

import UIKit

class SwiftController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.orange;
        
    }
    var count0 = 0;
    var count = 0;
    var count2 = 0;
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
//        fb();
        forCircle();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    ///---------------------------------------------------------
    
    //for循环应该遵循“外小内大”的原则
    func forCircle() {
        func bigSmall (){
            for _ in 0...1000 {
                for _ in 0...10 {
                    print("a")
                }
            }
        }
        func smallBig (){
            for _ in 0...10 {
                for _ in 0...1000 {
                    print("a")
                }
            }
        }
        let bg = measure {
            bigSmall();
        }
        let sm = measure {
            smallBig();
        }
        
        print("\(sm) === \(bg)")
        
    }
    
    
    
    
    ///---------------------------------------------------------
    
//    function trampoline(f) {
//    while (f && f instanceof Function) {
//    f = f();
//    }
//    return f;
//    }
    
    func factorial(n:Int64) -> Int64{
        if (n <= 1) {return 1};
        return n * factorial(n: n - 1);
    }
    func factorial2(n:Int64 , total:Int64) -> Int64 {
        if (n <= 1) {return 1};
        return n * factorial2(n: n - 1,total:n * total);
    }
    
    
    func measure(f: ()->()) -> Double{
        let start = CACurrentMediaTime()
        f()
        let end = CACurrentMediaTime()
        print("测量时间：\(end - start)-----------")
        return end - start;
    }
    
    // ------斐波那契数列
    func fb() -> Void {
        
        
        // 斐波那契数表
        func fibonacci_for(n:Int64) -> Int64{
            
            count0 = count0 + 1;
            if n < 1 {
                return 0;
            }
            if n < 2 {
                return 1;
            }
            
            var fibNF:Int64 = 0;
            var fibNS:Int64 = 1;
            var fibN:Int64 = 0;
            
            for _ in 2...n {
                fibN = fibNF + fibNS;
                fibNF = fibNS;
                fibNS = fibN;
            }
            
            return fibN;
        }
        func fibonacci_indirect(n:Int64)->Int64{
            count = count + 1;
            if n < 1 {
                return 0
            }
            if n < 2 {
                return 1
            }
            return fibonacci_indirect(n: n-1)+fibonacci_indirect(n: n-2)
        }
//        函数调用自身，称为递归。如果尾调用自身，就称为尾递归。
        func Fibonacci_tail (n:Int64, ac1:Int64 = 1, ac2:Int64 = 1) -> Int64{
            count2 = count2 + 1;
            if ( n < 1 ){return 0;}
            if ( n <= 1 ){return ac2;};
            return Fibonacci_tail (n: n - 1, ac1:ac2, ac2:ac1 + ac2);
        }
        
        func doSomeHeavyWork() {
            for index in 0...15 {
                print("第\(index)项结果:\(fibonacci_for(n: Int64(index)))")
            }
        }
        func doSomeHeavyWork2() {
            for index in 0...15 {
                print("第\(index)项结果:\(Fibonacci_tail (n: Int64(index)))")
            }
        }
        func doSomeHeavyWork3() {
            for index in 0...15 {
                print("第\(index)项结果:\(fibonacci_indirect (n: Int64(index)))")
            }
        }
        
        let m1 = measure {
            doSomeHeavyWork()
        }
        let m2 = measure {
            doSomeHeavyWork2()
        }
        let m3 = measure {
            doSomeHeavyWork3()
        }
        
        
        print("\(m1) == \(m2) == \(m3)");
        
//        var m1:Double = 0,m2:Double = 0;
//        for index in 1...30 {
//            let group = DispatchGroup()
//            let queue1 = DispatchQueue(label: "queue1")
//            queue1.async(group: group) {
//                m1 = self.measure {
//                    doSomeHeavyWork()
//                }
//            }
//            let queue2 = DispatchQueue(label: "queue2")
//            queue2.async(group: group) {
//                m2 = self.measure {
//                    doSomeHeavyWork2()
//                }
//            }
//            group.wait()    //等待group的任务都执行完成后向下执行
//                    print("\(m1) == \(m2)");
//            if (m1 < m2){
//                print("ok\(index)");
////                break;
//            }else{
//                print("not ok");
//            }
//        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
