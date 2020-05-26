INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (1, 35.3677151, 127.0344808, ' 전남 담양군 금성면 새덕굴길 135-88', '담양금성산성 오토캠핑장', 100197, ' CAMPING');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (2, 34.4702624, 126.9769258, ' 전남 장흥군 회진면 대리 115-2', '정남진 해양 낚시공원', 58139, ' HOSTEL');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (3, 34.7521973, 126.8969141, ' 전남 장흥군 부산면 지천리 260', '깊은내 펜션', 115041, ' PENSION');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (4, 34.6707815, 126.9255316, ' 전남 장흥군 장흥읍 우산리 120-1', '억불산 민박', 55665, ' PENSION');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (5, 34.6749284, 126.9562539, ' 전남 장흥군 안양면 기산리 21', '다예촌 민박체험학습장', 134833, ' PENSION');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (6, 34.6689928, 126.9222875, ' 전남 장흥군 장흥읍 우산리 426', '흙집세상', 38347, ' PENSION');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (7, 34.8370071, 126.8618416, ' 전남 장흥군 유치면 운월리 468-9', '하늘공원', 50717, ' PENSION');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (8, 34.6657932, 126.916638, ' 전남 장흥군 장흥읍 평화리 113', '둘레길펜션텔', 49480, ' MOTEL');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (9, 34.6399709, 126.8896543, ' 전남 장흥군 장흥읍 덕제리 614', '솔 무인텔', 139781, ' MOTEL');
INSERT INTO airbnb_db.accommodation (id, latitude, longitude, location, name, price, type)
VALUES (10, 34.6514529, 126.8893627, ' 전남 장흥군 장흥읍 덕제리 224', '궁 무인텔', 49480, ' MOTEL');


INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (1, ' MAIN',
        'https://images.unsplash.com/photo-1547593456-de8d74b25d75?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (1, ' DETAIL',
        'https://images.unsplash.com/photo-1567461006865-5eabe67d7cda?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (1, ' DETAIL',
        'https://images.unsplash.com/photo-1566126727069-6df012224264?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (1, ' DETAIL',
        'https://images.unsplash.com/photo-1544305776-64b90477a4da?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (2, ' MAIN',
        'https://images.unsplash.com/photo-1588614031655-50a85daed134?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (2, ' DETAIL',
        'https://images.unsplash.com/photo-1566399468396-07a2a14911a6?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (2, ' DETAIL',
        'https://images.unsplash.com/photo-1586114728935-cf9c40e26bb5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (2, ' DETAIL',
        'https://images.unsplash.com/photo-1581807889768-17e5c3c7af2e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (3, ' MAIN',
        'https://images.unsplash.com/photo-1567461006299-76f53b1e6585?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (3, ' DETAIL',
        'https://images.unsplash.com/photo-1562791454-fb9bfae3d7d6?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (3, ' DETAIL',
        'https://images.unsplash.com/photo-1579896274789-fd51a5765b88?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (3, ' DETAIL',
        'https://images.unsplash.com/photo-1562791454-fb9bfae3d7d6?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (4, ' MAIN',
        'https://images.unsplash.com/photo-1511465112067-19658af1f11e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (4, ' DETAIL',
        'https://images.unsplash.com/photo-1560111137-11374746a448?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (4, ' DETAIL',
        'https://images.unsplash.com/photo-1586114660116-60f888e9dc68?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (4, ' DETAIL',
        'https://images.unsplash.com/photo-1585733299032-d09430826b4c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (5, ' MAIN',
        'https://images.unsplash.com/photo-1421790735934-58176b8292a7?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (5, ' DETAIL',
        'https://images.unsplash.com/photo-1586128743915-ec7788189715?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (5, ' DETAIL',
        'https://images.unsplash.com/photo-1566393943037-399380229304?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (5, ' DETAIL',
        'https://images.unsplash.com/photo-1566126727069-6df012224264?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (6, ' MAIN',
        'https://images.unsplash.com/photo-1566126727069-6df012224264?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (6, ' DETAIL',
        'https://images.unsplash.com/photo-1531725695048-c645d0c6e2be?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (6, ' DETAIL',
        'https://images.unsplash.com/photo-1505492537188-de71a52767cb?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (6, ' DETAIL',
        'https://images.unsplash.com/photo-1527985510537-5372c52e303d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (7, ' MAIN',
        'https://images.unsplash.com/photo-1583146153103-abf58fc14bc5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (7, ' DETAIL',
        'https://images.unsplash.com/photo-1584813816573-177a9057d23c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (7, ' DETAIL',
        'https://images.unsplash.com/photo-1580988954232-0b4a1daa3efa?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (7, ' DETAIL',
        'https://images.unsplash.com/photo-1549168518-cac9e77676fc?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (8, ' MAIN',
        'https://images.unsplash.com/photo-1560108026-ba3c9d2ca388?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (8, ' DETAIL',
        'https://images.unsplash.com/photo-1584722965892-cda26057ce86?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (8, ' DETAIL',
        'https://images.unsplash.com/photo-1569676597473-4c15cdaf133c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (8, ' DETAIL',
        'https://images.unsplash.com/photo-1566633616444-fc0003e62c48?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (9, ' MAIN',
        'https://images.unsplash.com/photo-1588196308744-df471eb7c75c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (9, ' DETAIL',
        'https://images.unsplash.com/photo-1564379380755-614d148e5d22?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (9, ' DETAIL',
        'https://images.unsplash.com/photo-1545175707-9eec1209f720?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (9, ' DETAIL',
        'https://images.unsplash.com/photo-1588671185530-68131769bb69?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (10, ' MAIN',
        'https://images.unsplash.com/photo-1574772343276-8fe6699bbacd?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        0);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (10, ' DETAIL',
        'https://images.unsplash.com/photo-1582310449995-ec972163ac33?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        1);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (10, ' DETAIL',
        'https://images.unsplash.com/photo-1585045270712-b6d2513fca3b?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        2);
INSERT INTO airbnb_db.accommodation_images (accommodation_id, type, url, images_order)
VALUES (10, ' DETAIL',
        'https://images.unsplash.com/photo-1587921998917-3796a0db14f9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9',
        3);
