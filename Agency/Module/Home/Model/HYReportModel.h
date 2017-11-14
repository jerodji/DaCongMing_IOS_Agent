//
//  HYReportModel.h
//  Agency
//
//  Created by 胡勇 on 2017/11/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYReportModel : NSObject

@property (nonatomic,copy) NSString *sorder_id;
@property (nonatomic,copy) NSString *summary_commission;
@property (nonatomic,copy) NSString *buyer_id;
@property (nonatomic,copy) NSString *buyer_name;
@property (nonatomic,copy) NSString *buyer_head_image;
@property (nonatomic,copy) NSString *commission;
@property (nonatomic,copy) NSString *isreceive;
@property (nonatomic,copy) NSString *stat;
@property (nonatomic,copy) NSString *create_time;


@end

/**
 *  "sorder_id": "010201711131000001843141865",
 "summary_commission": 0,
 "buyer_id": "o-13Mv0oIXWCKKv9jpe5Ra59R9gY",
 "buyer_name": "_Levy",
 "buyer_head_image": "http://www.laopdr.cn/hpt_image/htp_201710271000000672247069.jpg",
 "commission": 0.016,
 "isreceive": "2",
 "stat": "2",
 "create_time": "2017-11-13 11:46:28"
 */
