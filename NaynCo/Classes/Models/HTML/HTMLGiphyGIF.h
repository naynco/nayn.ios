//
//  HTMLGiphyGIF.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.05.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface HTMLGiphyGIF : NSObject

@property (nonatomic) NSString *gifID;

-(instancetype)initWithID:(NSString *)identifier;

@end


//{
//    "data":
//    {
//        "type": "gif",
//        "id": "YlQQYUIEAZ76o",
//        "slug": "traffic-television-animated-YlQQYUIEAZ76o",
//        "url": "https://giphy.com/gifs/traffic-television-animated-YlQQYUIEAZ76o",
//        "bitly_gif_url": "https://gph.is/1adVLZR",
//        "bitly_url": "https://gph.is/1adVLZR",
//        "embed_url": "https://giphy.com/embed/YlQQYUIEAZ76o",
//        "username": "",
//        "source": "https://tumblr.com",
//        "rating": "g",
//        "content_url": "",
//        "source_tld": "tumblr.com",
//        "source_post_url": "https://tumblr.com",
//        "is_sticker": 0,
//        "import_datetime": "2014-02-02 08:03:24",
//        "trending_datetime": "2014-11-25 00:08:06",
//        "images":
//        {
//            "fixed_height_still":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200_s.gif",
//                "width": "267",
//                "height": "200"
//            },
//            "original_still":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy_s.gif",
//                "width": "406",
//                "height": "304"
//            },
//            "fixed_width":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200w.gif",
//                "width": "200",
//                "height": "150",
//                "size": "105406",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200w.mp4",
//                "mp4_size": "30571",
//                "webp": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200w.webp",
//                "webp_size": "115888"
//            },
//            "fixed_height_small_still":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100_s.gif",
//                "width": "134",
//                "height": "100"
//            },
//            "fixed_height_downsampled":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200_d.gif",
//                "width": "267",
//                "height": "200",
//                "size": "245334",
//                "webp": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200_d.webp",
//                "webp_size": "75796"
//            },
//            "preview":
//            {
//                "width": "298",
//                "height": "222",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy-preview.mp4",
//                "mp4_size": "40416"
//            },
//            "fixed_height_small":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100.gif",
//                "width": "134",
//                "height": "100",
//                "size": "169660",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100.mp4",
//                "mp4_size": "49334",
//                "webp": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100.webp",
//                "webp_size": "57196"
//            },
//            "downsized_still":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy-downsized_s.gif",
//                "width": "406",
//                "height": "304",
//                "size": "42674"
//            },
//            "downsized":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy-downsized.gif",
//                "width": "406",
//                "height": "304",
//                "size": "564559"
//            },
//            "downsized_large":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy.gif",
//                "width": "406",
//                "height": "304",
//                "size": "564559"
//            },
//            "fixed_width_small_still":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100w_s.gif",
//                "width": "100",
//                "height": "75"
//            },
//            "preview_webp":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy-preview.webp",
//                "width": "182",
//                "height": "136",
//                "size": "48312"
//            },
//            "fixed_width_still":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200w_s.gif",
//                "width": "200",
//                "height": "150"
//            },
//            "fixed_width_small":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100w.gif",
//                "width": "100",
//                "height": "75",
//                "size": "105406",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100w.mp4",
//                "mp4_size": "38412",
//                "webp": "https://media0.giphy.com/media/YlQQYUIEAZ76o/100w.webp",
//                "webp_size": "35484"
//            },
//            "downsized_small":
//            {
//                "width": "406",
//                "height": "304",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy-downsized-small.mp4",
//                "mp4_size": "92768"
//            },
//            "fixed_width_downsampled":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200w_d.gif",
//                "width": "200",
//                "height": "150",
//                "size": "138256",
//                "webp": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200w_d.webp",
//                "webp_size": "45484"
//            },
//            "downsized_medium":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy.gif",
//                "width": "406",
//                "height": "304",
//                "size": "564559"
//            },
//            "original":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy.gif",
//                "width": "406",
//                "height": "304",
//                "size": "564559",
//                "frames": "15",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy.mp4",
//                "mp4_size": "88870",
//                "webp": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy.webp",
//                "webp_size": "345056"
//            },
//            "fixed_height":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200.gif",
//                "width": "267",
//                "height": "200",
//                "size": "169660",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200.mp4",
//                "mp4_size": "26060",
//                "webp": "https://media0.giphy.com/media/YlQQYUIEAZ76o/200.webp",
//                "webp_size": "190906"
//            },
//            "looping":
//            {
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy-loop.mp4",
//                "mp4_size": "4077927"
//            },
//            "original_mp4":
//            {
//                "width": "480",
//                "height": "358",
//                "mp4": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy.mp4",
//                "mp4_size": "88870"
//            },
//            "preview_gif":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/giphy-preview.gif",
//                "width": "128",
//                "height": "96",
//                "size": "49155"
//            },
//            "480w_still":
//            {
//                "url": "https://media0.giphy.com/media/YlQQYUIEAZ76o/480w_s.jpg",
//                "width": "480",
//                "height": "359"
//            }
//        },
//        "title": "animated hanna-barbera GIF"
//    },
//    "meta":
//    {
//        "status": 200,
//        "msg": "OK",
//        "response_id": "5b02e46e716c6c5663c3dd8a"
//    }
//}
