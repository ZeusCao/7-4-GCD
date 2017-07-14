//
//  ViewController.swift
//  7-4-GCD
//
//  Created by Zeus on 2017/7/4.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 尾随闭包：如果函数的最后一个参数是闭包，函数的参数可以提前结束，最后一个参数直接使用{}包装闭包的代码
        // loadData(completion: <#T##([String]) -> ()#>)
        loadData { (result) in
            print("获取的新闻数据\(result)")
        }
        
    }

    /**
      在异步执行任务，获取结果，通过 block/闭包 回调
     闭包的应用场景和block完全一致
     */
    
    // 逃逸闭包：http://blog.csdn.net/feng2qing/article/details/53726002
    func loadData(completion: @escaping (_ result: [String]) -> ()) -> () {
        
        // 将任务添加到队列，指定执行任务的函数
        // 翻译：队列调度任务（block、闭包），以同步或者异步执行
        
        DispatchQueue.global().async() {
            print("耗时操作\(Thread.current)")
            
            // 休眠
            Thread.sleep(forTimeInterval: 1.0)
            
            // 获得结果
            let json = ["头条", "八卦"]
            
            
            // 主队列回调
            DispatchQueue.main.async(execute: {
                print("主线程更新UI \(Thread.current)")
                
                // 回调 -->>> 执行闭包（通过参数传递的）
                // 传递异步获取的结果
                completion(json)
                
            })
            
        }
        
    }


    func demo() {
        
        // 尾随闭包
        DispatchQueue.global().async { 
            
            // 嵌套的gcd，xcode不会改成尾随闭包
            DispatchQueue.main.async(execute: { 
                <#code#>
            }) // 去掉括号运行结果还是一样的
            
        }
        
        // 尾随闭包
        DispatchQueue.main.async { 
            
        }
        
        
    }
    
    
    
    
    
    
    
}

