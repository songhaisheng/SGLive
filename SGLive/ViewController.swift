//
//  ViewController.swift
//  SGLive
//
//  Created by SG on 17/1/5.
//  Copyright © 2017年 SG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 在模拟器上声音和画面不同步或者比较卡顿的现象在真机没事的，不用太担心。
    fileprivate var player: IJKFFMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         * 参考的博客地址: http://www.jianshu.com/p/a7d9ed02cf40
         *              http://www.jianshu.com/p/4f21af680c19
         *              http://www.jianshu.com/p/b8db6c142aad
         */

        let options:IJKFFOptions = IJKFFOptions.byDefault();
        // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
        options.setOptionIntValue(15, forKey: "max-fps", of: kIJKFFOptionCategoryPlayer);
        #if DEBUG
            //  设置报告日志
            IJKFFMoviePlayerController.setLogReport(true);
            //  设置日志的级别为Debug
            IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_DEBUG);
        #else
            //  设置不报告日志
            IJKFFMoviePlayerController.setLogReport(false);
            //  设置日志级别为信息
            IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO);
        #endif
        // http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8 该地址正常有效
        self.player = IJKFFMoviePlayerController(contentURL: URL(string: "http://hdl.9158.com/live/f19ec5874c1d34e69e8be275a143f5d6.flv"), with: options);
        // 设置适配横竖屏(设置四边固定,长宽灵活)
        self.player?.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight];
        self.player?.view.frame = self.view.bounds;
        // 填充fill
        self.player?.scalingMode = IJKMPMovieScalingMode.aspectFill;
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
        self.player?.shouldAutoplay = true;
        self.view.autoresizesSubviews = true;
//        if (isReset)
//        {
//            self.view.insertSubview(self.player!.view, belowSubview: self.pagesView);
//        }
//        else
//        {
            self.view.addSubview(self.player!.view);
//        }
//        self.addPlayerNotificationObservers();
        // 播放
        self.player?.prepareToPlay();
//        self.playState = 1;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

