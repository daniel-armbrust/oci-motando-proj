-- BRANDS
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (1, 'BMW', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (2, 'Aprilia', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (3, 'Bajaj', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (4, 'Dafra', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (5, 'Ducati', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (6, 'Harley Davidson', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (7, 'Honda', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (8, 'Husqvarna', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (9, 'Indian', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (10, 'Kasinski', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (11, 'Kawasaki', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (12, 'KTM', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (13, 'MV Agusta', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (14, 'Royal Enfield', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (15, 'Suzuki', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (16, 'Triumph', true);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (17, 'Voltz', false);
INSERT INTO motorcycle_brands (id, brand, popular) VALUES (18, 'Yamaha', true);


INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (1, 'C 600', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (1, 'Sport Highline', 1);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (2, 'F 650', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (2, 'Cs', 2);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (3, 'Gs', 2);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (4, 'Gs Dakar 50Cv', 2);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (5, 'Gs Standard 800', 2);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (3, 'F 700', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (6, 'Gs Premium', 3);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (7, 'Gs Sport', 3);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (4, 'F 750', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (8, 'Gs Premium', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (9, 'Gs Premium 40 Years', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (10, 'Gs Premium(Kit Baixo)', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (11, 'Gs Sport', 4);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (5, 'F 800 GS', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (12, 'Adventure', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (13, 'Adventure Premium', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (14, 'Premium', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (15, 'Premium Triple Black', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (16, 'Std', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (17, 'Top', 5);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (6, 'F 800 R', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (18, 'Premium', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (19, 'Std', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (20, 'Top', 6);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (7, 'F 850', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (21, 'Gs Adventure', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (22, 'Gs Adventure 40 Years', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (23, 'Gs Adventure Premium', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (24, 'Gs Adventure Premium 40 Years', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (25, 'Gs Adventure Sport', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (26, 'Gs Premium', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (27, 'Gs Premium +', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (28, 'Gs Premium 40 Years', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (29, 'Gs Sport', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (30, 'Premium(Kit Baixo)', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (31, 'Premium(Tft)', 7);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (8, 'F 900', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (32, 'R', 8);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (9, 'G 310 GS', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (33, 'Std', 9);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (10, 'G 310 R', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (34, 'Std', 10);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (11, 'G 650 GS', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (35, 'Premium', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (36, 'Sertao', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (37, 'Std', 11);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (12, 'K 1100', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (38, 'Rs', 12);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (13, 'K 1200', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (39, 'Gt Premium', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (40, 'Lt', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (41, 'Lt Face Lift', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (42, 'R Special', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (43, 'Rs', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (44, 'S Standard', 13);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (14, 'K 1300 GT', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (45, 'Premium', 14);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (15, 'K 1300 R', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (46, 'Premium', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (47, 'Std', 15);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (16, 'K 1300 S', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (48, 'Premium', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (49, 'Sport', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (50, 'Std', 16);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (17, 'K 1600', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (51, 'Bagger', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (52, 'Gt Premium', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (53, 'Gt Premium Sistema Audio', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (54, 'Gt Standard', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (55, 'Gtl Exclusive Premium', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (56, 'Gtl Premium', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (57, 'Gtl Std', 17);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (18, 'R 1100', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (58, 'Gs', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (59, 'R', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (60, 'Rs', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (61, 'Rt', 18);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (19, 'R 1150', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (62, 'Gs', 19);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (63, 'R', 19);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (64, 'R Rockster', 19);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (65, 'Rs', 19);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (66, 'Rt', 19);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (20, 'R 1200 GS', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (67, 'Adventure', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (68, 'Adventure Exclusive', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (69, 'Adventure Premium', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (70, 'Adventure Premium Triple Black', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (71, 'Adventure Rallye', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (72, 'Adventure Top', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (73, 'Exclusive', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (74, 'Hp2', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (75, 'Premium', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (76, 'Premium Rallye', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (77, 'Premium Triple Black', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (78, 'Rallye', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (79, 'Sport', 20);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (80, 'Standard', 20);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (21, 'R 1200 R', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (81, 'Classic', 21);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (22, 'R 1200 RT', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (82, 'Premium', 22);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (83, 'Standard', 22);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (84, 'Top', 22);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (23, 'R 1250 GS', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (85, 'Adventure', 23);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (86, 'Adventure Premium', 23);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (87, 'Adventure Rally', 23);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (88, 'Premium', 23);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (89, 'Premium Exclusive', 23);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (90, 'Premium Hp', 23);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (91, 'Sport', 23);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (92, 'Standard', 23);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (24, 'R 1250 RT', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (93, 'Premium Spezial', 24);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (94, 'Standard', 24);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (25, 'R 18', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (95, 'Pure', 25);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (26, 'R Nine T', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (96, 'Premium', 26);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (27, 'S 1000 R', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (97, 'Full', 27);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (98, 'Premium', 27);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (28, 'S 1000 RR', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (99, 'Carbon', 28);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (100, 'Full', 28);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (101, 'Hp4 Competition', 28);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (102, 'Std', 28);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (29, 'S 1000 XR', 1);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (103, 'Premium', 29);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (104, 'Std', 29);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (30, 'Pegaso', 2);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (105, '650', 30);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (31, 'RS', 2);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (106, '250', 31);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (32, 'RSV Mille', 2);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (107, '1000', 32);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (33, 'Rally', 2);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (108, '50', 33);


INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (34, 'Dominar', 3);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (109, '160', 34);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (110, '200', 34);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (111, '400', 34);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (35, 'Cityclass', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (112, '200I', 35);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (36, 'Citycom', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (113, 'Hd 300', 36);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (114, 'S 300I', 36);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (115, 'S 300I Abs', 36);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (116, 'S 300I Cbs', 36);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (37, 'Cruisym', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (117, '150 Cbs', 37);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (118, '300', 37);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (38, 'Horizon', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (119, '150', 38);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (120, '250', 38);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (39, 'Kansas', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (121, '250', 39);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (40, 'NH', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (122, '190', 40);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (123, '300', 40);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (41, 'Next', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (124, '250', 41);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (125, '300', 41);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (42, 'Riva', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (126, '150', 42);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (43, 'Super', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (127, '50', 43);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (44, 'Sym Citycom', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (128, '300I', 44);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (45, 'Sym Maxsym', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (129, '400I', 45);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (46, 'TVS Apache', 4);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (130, 'Rtr 200', 46);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (131, 'Rtr 200 Abs', 46);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (47, 'Diavel', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (132, '1198', 47);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (133, '1260 S', 47);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (134, 'Carbon 1198', 47);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (135, 'Carbon Red 1198', 47);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (136, 'Cromo 1198', 47);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (137, 'Dark 1198', 47);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (48, 'Hypermotard', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (138, '1100', 48);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (139, '821', 48);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (49, 'Monster', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (140, '1100', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (141, '1100 S', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (142, '1100 S Abs', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (143, '1200', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (144, '1200 S', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (145, '695', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (146, '696', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (147, '796', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (148, '797', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (149, '821', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (150, '900', 49);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (151, 'S2 R 1000', 49);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (50, 'Multistrada', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (152, '1100', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (153, '1200', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (154, '1200 Enduro', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (155, '1200 Enduro Limited Edition', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (156, '1200 S', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (157, '1200 S Pikes Peak', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (158, '1200 S Sport', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (159, '1200 S Touring', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (160, '1200 Sport', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (161, '1260', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (162, '1260 S', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (163, '620', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (164, '950', 50);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (165, '950 S', 50);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (51, 'Panigale', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (166, '1199', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (167, '1199 R', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (168, '1199 S', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (169, '1199 S Senna', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (170, '1299', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (171, '1299 S', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (172, '959', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (173, 'V4 R 998', 51);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (174, 'V4 S 1103', 51);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (52, 'Scrambler', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (175, '796', 52);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (176, 'Custom 803', 52);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (177, 'Full Trottle 803', 52);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (178, 'Icon 803', 52);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (53, 'Streetfighter', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (179, '1099', 53);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (180, 'V4 S 1103', 53);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (54, 'SuperSport', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (181, 'S 900', 54);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (55, 'Superbike', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (182, '1098', 55);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (183, '1198 Sp', 55);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (184, '749', 55);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (185, '848', 55);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (186, '848 Evo', 55);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (187, '999', 55);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (188, '999 R Xerox', 55);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (56, 'Xdiavel', 5);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (189, '1262', 56);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (190, 'Dark 1262', 56);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (191, 'S 1262', 56);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (57, 'Breakout', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (192, '114 Softail', 57);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (193, 'Cvo', 57);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (194, 'Softail', 57);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (58, 'CVO', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (195, 'Limited Flhtkse', 58);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (196, 'Ultra Classic Electra Glide Flhtcuse7', 58);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (59, 'Dyna', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (197, 'Glide Low Rider', 59);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (198, 'Low Rider', 59);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (199, 'Super Glide', 59);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (200, 'Super Glide Custom', 59);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (201, 'Switchback', 59);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (202, 'Wide Glide', 59);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (60, 'Fat Bob', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (203, '114 Solftail', 60);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (204, 'Dyna', 60);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (205, 'Softail', 60);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (61, 'Heritage', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (206, 'Classic 114 Softail', 61);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (207, 'Classic Softail', 61);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (208, 'Custom Softail', 61);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (62, 'Pan America 1250', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (209, 'Special', 62);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (63, 'Screamin Eagle', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (210, 'Fat Boy', 63);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (211, 'Ultra Electra Glide', 63);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (64, 'Shovelhead', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (212, '1200', 64);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (65, 'Softail', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (213, 'Blackline Fxs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (214, 'Custom', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (215, 'Deluxe', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (216, 'Deluxe 1 Tom Flde', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (217, 'Deluxe 2 Tons Flde', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (218, 'Deluxe Cor Custom Flde', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (219, 'Deluxe Flde', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (220, 'Deuce Fxstdi', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (221, 'Fat Boy', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (222, 'Fat Boy 1 Tom Flfb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (223, 'Fat Boy 114 1 Tom Flfbs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (224, 'Fat Boy 114 115Th Anniversary Flfbs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (225, 'Fat Boy 114 2 Tons Flfbs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (226, 'Fat Boy 114 Cor Custom Flfbs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (227, 'Fat Boy 114 Flfbs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (228, 'Fat Boy 1700 Flstf', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (229, 'Fat Boy 2 Tons Flfb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (230, 'Fat Boy 2 Tons Flstf', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (231, 'Fat Boy Flfb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (232, 'Fat Boy Flstf', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (233, 'Fat Boy Low', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (234, 'Fat Boy Special 1700 1 Tom Flstfb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (235, 'Fat Boy Special 1700 Flstfb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (236, 'Fat Boy Special Black 110Th Anniversary Flstfb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (237, 'Fat Boy Special Black Flstfb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (238, 'Fxdr 114 1 Tom Fxdrs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (239, 'Fxdr 114 Fxdrs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (240, 'Heritage Springer', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (241, 'Low Rider S 1 Tom Fxlrs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (242, 'Low Rider S Fxlrs', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (243, 'Night Train', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (244, 'Night Train Fxstb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (245, 'Rocker 1600', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (246, 'Rocker C 1600 Fxcwc', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (247, 'Slim 1 Tom Flsl', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (248, 'Slim Flsl', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (249, 'Softail Deluxe 1700 Flstn', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (250, 'Softail Deluxe Flstn', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (251, 'Springer', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (252, 'Springer Classic', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (253, 'Standard Fxsti', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (254, 'Street Bob 1 Tom Fxbb', 65);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (255, 'Street Bob Fxbb', 65);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (66, 'Sport Glide', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (256, 'Softail 7', 66);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (67, 'Sportster 1200', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (257, 'Custom Limited Edition', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (258, 'Forty Eight 115Th Anniversary', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (259, 'Forty-Eight', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (260, 'Forty-Eight Hard Candy Custom', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (261, 'Iron', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (262, 'Roadster', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (263, 'Xl Custom', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (264, 'Xl Nightster', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (265, 'Xl-C Custom', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (266, 'Xr', 67);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (267, 'Xr-X', 67);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (68, 'Sportster 883', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (268, 'Iron', 68);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (269, 'Xl Low', 68);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (270, 'Xl R Roadster', 68);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (271, 'Xl Standard', 68);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (272, 'Xlh', 68);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (69, 'Street Bob', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (273, 'Dyna', 69);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (70, 'Street Glide', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (274, '1 Tom Flhx', 70);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (275, 'Cvo 2', 70);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (276, 'Flhxse', 70);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (277, 'Special 1700 1 Tom Flhxs', 70);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (278, 'Special 1700 2 Tons Flhxs', 70);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (279, 'Special 1700 Flhxs', 70);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (280, 'Special Touring', 70);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (281, 'Touring', 70);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (71, 'Touring', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (282, 'Electra Glide', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (283, 'Electra Glide Classic', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (284, 'Electra Glide Classic Flhtci', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (285, 'Electra Glide Ultra', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (286, 'Electra Glide Ultra Classic Screamin Eagle Flhtcu', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (287, 'Electra Glide Ultra Limited 2 Tons Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (288, 'Electra Glide Ultra Limited Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (289, 'Road Glide Limited Fltrk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (290, 'Road Glide Special 1700 Fltrxs', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (291, 'Road King Classic 1700 1 Tom Flhrc', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (292, 'Road King Classic Flhrc', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (293, 'Ultra Electra Glide Classic Flhtcu', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (294, 'Ultra Glide', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (295, 'Ultra Glide Tri', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (296, 'Ultra Limited 1700 1 Tom Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (297, 'Ultra Limited 1700 115Th Anniversary Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (298, 'Ultra Limited 1700 2 Tons Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (299, 'Ultra Limited 1700 Cor Custom Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (300, 'Ultra Limited 1700 Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (301, 'Ultra Limited 1800 1 Tom Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (302, 'Ultra Limited 1800 2 Tons Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (303, 'Ultra Limited 1800 Cor Custom Flhtk', 71);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (304, 'Ultra Limited 1800 Flhtk', 71);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (72, 'V-Rod', 6);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (305, '10Th Anniversary Edition', 72);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (306, '1150 Vrsc', 72);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (307, '1250 Vrsc', 72);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (308, 'Muscle', 72);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (309, 'Night Rod Special', 72);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (310, 'Street Rod', 72);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (73, 'Biz', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (311, '100 Es', 73);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (312, '110 I', 73);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (313, '125', 73);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (314, '125 +', 73);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (315, '125 Es', 73);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (316, '125 Ex', 73);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (317, '125 Ex Flexone', 73);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (318, '125 Ks', 73);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (74, 'C 100', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (319, 'Biz', 74);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (320, 'Biz +', 74);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (321, 'Biz Es', 74);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (322, 'Dream', 74);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (75, 'CB 1000', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (323, 'R 142Cv Abs', 75);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (324, 'R Barracuda C-Abs', 75);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (325, 'R C-Abs', 75);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (326, 'R Hornet Big One Abs', 75);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (327, 'R Hornet Big One Std', 75);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (328, 'R Std', 75);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (329, 'R Tricolor C-Abs', 75);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (76, 'CB 1300', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (330, 'Super Four Abs', 76);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (331, 'Super Four Std', 76);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (77, 'CB 300', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (332, 'R C-Abs', 77);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (333, 'R C-Abs', 77);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (334, 'R C-Abs Flexone', 77);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (335, 'R Repsol Std', 77);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (336, 'R Std', 77);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (337, 'R Std Flexone', 77);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (78, 'CB 400', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (338, 'Std', 78);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (79, 'CB 450', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (339, 'Dx', 79);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (340, 'Std', 79);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (341, 'Tr', 79);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (80, 'CB 500', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (342, 'F Abs', 80);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (343, 'F Std', 80);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (344, 'Std', 80);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (345, 'X Abs', 80);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (346, 'X Std', 80);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (81, 'CB 600', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (347, 'F Hornet', 81);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (348, 'F Hornet Abs', 81);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (349, 'F Hornet Std', 81);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (350, 'F Std', 81);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (82, 'CB 650', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (351, 'F Abs', 82);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (352, 'F Std', 82);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (353, 'R', 82);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (354, 'R Abs', 82);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (83, 'CB 750', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (355, 'K', 83);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (84, 'CB 900', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (356, 'F Hornet', 84);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (85, 'CB Twister', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (357, '250 Abs Flexone', 85);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (358, '250 Cbs Flexone', 85);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (359, '250 Special Edition Abs Flexone', 85);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (360, '250 Std Flexone', 85);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (86, 'CBR 1000', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (361, 'F', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (362, 'Rr Fireblade 192Cv Abs', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (363, 'Rr Fireblade Abs', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (364, 'Rr Fireblade Repsol', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (365, 'Rr Fireblade Repsol Hrc Tricolor C-Abs', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (366, 'Rr Fireblade Sp Abs', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (367, 'Rr Fireblade Std', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (368, 'Rr Racing Repsol', 86);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (369, 'Rr-R Fireblade Sp', 86);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (87, 'CBR 1100', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (370, 'Xx Super Blackbird', 87);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (88, 'CBR 250', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (371, 'R C-Abs', 88);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (372, 'R Std', 88);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (89, 'CBR 450', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (373, 'Sr', 89);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (90, 'CBR 500', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (374, 'R Abs', 90);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (375, 'R Std', 90);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (91, 'CBR 600', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (376, 'F', 91);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (377, 'F C-Abs', 91);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (378, 'F Std', 91);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (379, 'Rr Abs', 91);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (380, 'Rr Repsol C-Abs', 91);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (381, 'Rr Std', 91);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (92, 'CBR 650', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (382, 'F Abs', 92);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (383, 'F Std', 92);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (384, 'R', 92);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (93, 'CBR 900', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (385, 'Rr Fireblade', 93);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (94, 'CBR 954', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (386, 'Rr Fireblade', 94);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (95, 'CBX 1000', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (387, 'Sport', 95);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (96, 'CBX 150', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (388, 'Aero', 96);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (97, 'CBX 200', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (389, 'Strada', 97);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (98, 'CBX 250', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (390, 'Twister', 98);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (99, 'CBX 750', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (391, 'Four', 99);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (392, 'Four Indy', 99);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (100, 'CG 125', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (393, 'Cargo', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (394, 'Cargo Es', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (395, 'Cargo Ks', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (396, 'Fan', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (397, 'Fan Es', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (398, 'Fan Esd', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (399, 'Fan Ks', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (400, 'Std', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (401, 'Titan', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (402, 'Titan Ks', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (403, 'Titan Kse', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (404, 'Today', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (405, 'Turuna', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (406, 'I Cargo', 100);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (407, 'I Fan', 100);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (101, 'CG 150', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (408, 'Fan Cargo Esdi Mix', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (409, 'Fan Esdi Mix', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (410, 'Fan Esi', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (411, 'Fan Esi Mix', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (412, 'Job', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (413, 'Sport', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (414, 'Start Es Mix', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (415, 'Titan Es', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (416, 'Titan Es Mix', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (417, 'Titan Esd', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (418, 'Titan Esd Mix', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (419, 'Titan Ex Mix', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (420, 'Titan Ex Mix Flexone', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (421, 'Titan Ks', 101);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (422, 'Titan Ks Mix', 101);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (102, 'CG 160', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (423, 'Cargo', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (424, 'Cargo Esdi', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (425, 'Fan', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (426, 'Fan Esdi', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (427, 'Start', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (428, 'Start Cbs', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (429, 'Titan', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (430, 'Titan Ex', 102);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (431, 'Titan S', 102);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (103, 'CR', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (432, '125', 103);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (433, '250 R', 103);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (104, 'CRF', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (434, '1000L Africa Twin', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (435, '1000L Africa Twin Abs', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (436, '1000L Africa Twin Adventure Sports', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (437, '1000L Africa Twin Adventure Sports Travel Edition', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (438, '1000L Africa Twin Te', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (439, '1100L Africa Twin', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (440, '1100L Africa Twin Adventure Sports Es', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (441, '1100L Africa Twin Adventure Sports Es Dct', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (442, '1100L Africa Twin Dct', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (443, '150F', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (444, '230F', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (445, '250F', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (446, '250L', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (447, '250R', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (448, '250Rx', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (449, '250X', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (450, '450R', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (451, '450Rx', 104);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (452, '450X', 104);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (105, 'CTX', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (453, '700N', 105);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (106, 'CX', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (454, '500', 106);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (107, 'Elite', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (455, '125', 107);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (108, 'Forza', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (456, '350', 108);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (109, 'Gold Wing', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (457, '1500', 109);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (458, '1800', 109);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (459, 'Gl 1800', 109);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (460, 'Gl 1800 126Cv Abs', 109);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (461, 'Gl 1800 40Th Anniversary Edition C-Abs', 109);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (462, 'Gl 1800 C-Abs', 109);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (463, 'Gl 1800 Tour', 109);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (110, 'Honda ADV', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (464, '150 Abs', 110);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (111, 'Lead', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (465, '110', 111);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (112, 'ML 125', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (466, 'Std', 112);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (113, 'Magna 750', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (467, 'Std', 113);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (114, 'NC', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (468, '700X Abs', 114);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (469, '700X Std', 114);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (470, '750S Abs', 114);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (471, '750X Abs', 114);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (472, '750X Abs Nac', 114);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (473, '750X Std', 114);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (115, 'NX 150', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (474, 'Std', 115);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (116, 'NX 200', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (475, 'Std', 116);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (117, 'NX 350', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (476, 'Sahara', 117);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (118, 'NX 4', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (477, 'Falcon 400', 118);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (119, 'NX 400i', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (478, 'Falcon', 119);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (479, 'Falcon Africa Twin', 119);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (120, 'NXR 125', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (480, 'Bros Es', 120);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (481, 'Bros Ks', 120);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (121, 'NXR 150', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (482, 'Bros Es', 121);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (483, 'Bros Es Mix', 121);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (484, 'Bros Esd', 121);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (485, 'Bros Esd Mix', 121);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (486, 'Bros Ks', 121);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (487, 'Bros Ks Mix', 121);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (122, 'NXR 160', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (488, 'Bros', 122);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (489, 'Bros Esd Mix', 122);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (490, 'Bros Esdd Cbs', 122);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (491, 'Bros Esdd Mix', 122);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (492, 'Bros Esdd Special Edition Cbs', 122);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (123, 'PCX', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (493, '150', 123);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (494, '150 Dlx', 123);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (495, '150 Sport', 123);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (496, '150 Std Abs', 123);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (497, '150 Std Cbs', 123);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (124, 'Pop', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (498, '100', 124);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (499, '110I', 124);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (125, 'Quadriciclo For Traxx', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (500, '420', 125);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (126, 'SH', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (501, '150I', 126);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (502, '150I Dlx', 126);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (503, '300I', 126);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (504, '300I C-Abs', 126);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (127, 'Shadow', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (505, '1100 Ac', 127);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (506, '750', 127);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (507, '750 C-Abs', 127);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (508, 'Am 750', 127);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (128, 'VFR 1200F', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (509, 'Std', 128);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (129, 'VFR 1200X', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (510, 'Crosstourer', 129);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (130, 'VT 1300', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (511, 'Cx Fury', 130);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (131, 'VT 600', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (512, 'C Shadow', 131);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (132, 'VTX 1800', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (513, 'C', 132);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (514, 'R', 132);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (133, 'Valkyrie', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (515, '1500', 133);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (134, 'X-Adv', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (516, '750', 134);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (135, 'XL 1000V', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (517, 'Varadero', 135);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (518, 'Varadero Abs', 135);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (136, 'XL 125', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (519, 'S', 136);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (137, 'XL 250', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (520, 'R', 137);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (138, 'XL 700V', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (521, 'Transalp', 138);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (522, 'Transalp C-Abs', 138);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (139, 'XLR 125', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (523, 'Std', 139);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (140, 'XLX 250', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (524, 'R', 140);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (141, 'XLX 350', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (525, 'R', 141);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (142, 'XR 200', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (526, 'R', 142);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (143, 'XR 250', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (527, 'Tornado', 143);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (144, 'XRE 190', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (528, 'Abs', 144);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (529, 'Adventure Special Edition Abs', 144);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (145, 'XRE 300', 7);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (530, '(Rally)', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (531, '(Rally)(C-Abs)', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (532, 'Adventure', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (533, 'Adventure Abs', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (534, 'Rally Abs', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (535, 'Std', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (536, 'Std', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (537, 'Std Abs', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (538, 'Std C-Abs', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (539, 'Std C-Abs Flexone', 145);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (540, 'Std Flexone', 145);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (146, '701', 8);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (541, 'Enduro', 146);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (542, 'Vitpilen', 146);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (147, 'SM', 8);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (543, '510', 147);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (544, '610Ie', 147);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (148, 'TE', 8);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (545, '450', 148);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (149, 'WR', 8);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (546, '360', 149);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (150, 'Chief', 9);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (547, 'Classic 1811', 150);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (548, 'Vintage 1811', 150);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (151, 'Chieftain', 9);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (549, '1811', 151);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (152, 'Roadmaster', 9);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (550, '1811', 152);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (153, 'Scout', 9);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (551, '1133', 153);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (552, 'Bobber 1133', 153);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (154, 'Comet', 10);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (553, 'Gt 250', 154);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (554, 'Gt 250R', 154);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (555, 'Gt 250R 29Cv', 154);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (556, 'Gt 650R', 154);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (557, 'Phase 2 250', 154);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (155, 'Cruise', 10);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (558, 'Ii Classic 125', 155);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (156, 'Mirage', 10);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (559, '150', 156);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (560, '250', 156);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (561, '250 Dual Tone', 156);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (562, 'Premier 250', 156);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (157, 'Mirage Power', 10);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (563, '650 75Cv', 157);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (158, 'Prima Electra', 10);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (564, '2000W', 158);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (159, 'RX 125', 10);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (565, 'Std', 159);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (160, 'Classic', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (566, '100', 160);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (161, 'Concours', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (567, '1400', 161);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (568, '1400 Abs', 161);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (162, 'D-Tracker X', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (569, '250', 162);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (163, 'ER-6N', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (570, '650 Abs', 163);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (571, '650 Std', 163);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (164, 'KLX', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (572, '110', 164);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (573, '110 Monster', 164);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (574, '450', 164);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (575, '450 R', 164);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (165, 'KX', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (576, '250X', 165);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (577, '450', 165);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (578, '450F', 165);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (579, '450X', 165);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (166, 'Ninja', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (580, '1000 Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (581, '1000 Std', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (582, '1000 Tourer', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (583, '250R', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (584, '300 Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (585, '300 Special Edition', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (586, '300 Std', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (587, '400', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (588, '400 Krt', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (589, '650 Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (590, '650 Krt Edition', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (591, '650 Se', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (592, '650 Std', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (593, '650R Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (594, '650R Std', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (595, 'Zx-10 1000', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (596, 'Zx-10R 1000', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (597, 'Zx-10R 1000 Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (598, 'Zx-10R 1000 Nac Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (599, 'Zx-10R 1000 Se', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (600, 'Zx-10R 1000 Se Std', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (601, 'Zx-10Rr 1000', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (602, 'Zx-11 1100', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (603, 'Zx-14 1400 Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (604, 'Zx-14R 1400 Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (605, 'Zx-6 600', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (606, 'Zx-6R 600', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (607, 'Zx-6R 636', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (608, 'Zx-6R 636 136Cv', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (609, 'Zx-6R 636 Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (610, 'Zx-6R 636 Se Abs', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (611, 'Zx-9R 900', 166);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (612, 'Zz-R 1200', 166);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (167, 'Versys', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (613, '1000', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (614, '1000 120Cv Abs', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (615, '650 Abs', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (616, '650 City', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (617, 'Grand Tourer 1000', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (618, 'Grand Tourer 1000 120Cv Abs', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (619, 'Tourer 650 Abs', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (620, 'Tourer 650 Nac', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (621, 'X 300', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (622, 'X 300 Abs', 167);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (623, 'X Tourer 300 Abs', 167);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (168, 'Vulcan', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (624, '650', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (625, '800 Classic', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (626, '900 Classic', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (627, '900 Classic Lt', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (628, 'En 500', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (629, 'Nomad 1500', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (630, 'S 650', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (631, 'S 650 Abs', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (632, 'S 650 Grafismo Exclusivo Abs', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (633, 'S Cafe 650', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (634, 'S Special Edition 650', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (635, 'Vn 1500', 168);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (636, 'Vn 750', 168);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (169, 'Z', 11);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (637, '1000 Abs', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (638, '1000 R 142Cv Abs', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (639, '1000 R Edition', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (640, '1000 Std', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (641, '300 Abs', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (642, '300 Std', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (643, '400', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (644, '650 Abs', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (645, '650 Se', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (646, '750 Abs', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (647, '750 Std', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (648, '800 Abs', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (649, '800 Std', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (650, '900', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (651, '900 Rs', 169);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (652, '900 Rs Cafe', 169);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (170, '1190', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (653, 'Adventure', 170);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (654, 'Adventure R', 170);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (171, '1290', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (655, 'Super Adventure', 171);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (656, 'Super Adventure R', 171);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (657, 'Super Adventure S', 171);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (658, 'Super Duke R', 171);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (172, '200', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (659, 'Duke', 172);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (173, '250 F', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (660, 'Sx', 173);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (174, '250 Motocross', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (661, 'Sx', 174);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (175, '300 Off Road', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (662, 'Exc', 175);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (176, '390', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (663, 'Duke', 176);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (177, '450 F', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (664, 'Sx', 177);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (178, '450 Motocross', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (665, 'Sx', 178);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (179, '640', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (666, 'Adventure Lc4', 179);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (180, '950', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (667, 'Adventure S', 180);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (181, '990', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (668, 'Adventure', 181);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (669, 'Supermoto R', 181);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (670, 'Supermoto T', 181);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (182, 'EXC', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (671, '250', 182);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (672, '300', 182);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (673, '450', 182);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (674, 'F 250', 182);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (675, 'F 250 Six Days', 182);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (676, 'F 350', 182);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (677, 'F 350 Six Days', 182);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (183, 'SX', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (678, '50', 183);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (679, '65', 183);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (680, '85', 183);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (184, 'SX-F', 12);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (681, '350', 184);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (185, 'Brutale', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (682, '1090 Rr', 185);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (683, '800', 185);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (186, 'Brutale S', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (684, '910', 186);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (187, 'F3', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (685, '800', 187);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (188, 'F4', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (686, '1000 R', 188);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (189, 'Rivale', 13);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (687, '800', 189);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (190, 'Bullet', 14);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (688, '500', 190);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (689, '500 Forest Green Abs', 190);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (191, 'Classic', 14);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (690, '500', 191);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (691, '500 Abs', 191);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (692, '500 Chrome Black Abs', 191);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (693, '500 Chrome Green Abs', 191);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (694, '500 Efi', 191);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (695, '500 Redditch Abs', 191);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (192, 'Continental GT', 14);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (696, '535', 192);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (697, '535 Abs', 192);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (698, '650', 192);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (699, '650 British Racing Green', 192);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (700, '650 Ice Queen', 192);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (193, 'Himalayan', 14);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (701, '411', 193);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (702, '411 Granite Black', 193);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (703, '411 Gravel Grey', 193);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (704, '411 Lake Blue', 193);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (705, '411 Pine Green', 193);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (706, '411 Rock Red', 193);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (707, '411 Snow White', 193);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (194, 'Interceptor', 14);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (708, '650', 194);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (709, '650 Custom', 194);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (710, '650 Downtown Drag Grey', 194);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (711, '650 Mark 2', 194);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (712, '650 Ravishing Red', 194);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (713, '650 Sunset Strip Black', 194);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (195, 'Meteor', 14);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (714, '350 Fireball Red Abs', 195);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (715, '350 Fireball Yellow Abs', 195);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (716, '350 Stellar Blue Abs', 195);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (717, '350 Stellar Red Abs', 195);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (718, '350 Supernova Blue Abs', 195);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (719, '350 Supernova Brown Abs', 195);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (196, 'Address/AG', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (720, '100', 196);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (197, 'B-King', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (721, '1350', 197);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (198, 'Bandit', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (722, '1200S', 198);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (723, '1250S', 198);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (724, '600S', 198);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (725, '650S', 198);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (726, 'N1200', 198);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (727, 'N1250', 198);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (728, 'N600', 198);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (729, 'N650', 198);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (199, 'Boulevard', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (730, 'C1500', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (731, 'M109 R', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (732, 'M1500', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (733, 'M1800 R', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (734, 'M1800 R Boss', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (735, 'M1800 Rbz', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (736, 'M1800 Rs', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (737, 'M800', 199);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (738, 'M800 R', 199);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (200, 'Burgman', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (739, '400', 200);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (740, '650', 200);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (741, '650 Executive', 200);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (742, 'An 125', 200);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (743, 'I 125', 200);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (201, 'DR', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (744, '650 Re', 201);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (745, '650 Rse', 201);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (746, '800 S', 201);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (202, 'DR-Z 400', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (747, 'E', 202);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (203, 'Freewind', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (748, 'Xf650', 203);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (204, 'GS', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (749, '120', 204);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (750, '500 E', 204);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (205, 'GSR', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (751, '125', 205);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (752, '150I', 205);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (753, 'N 750', 205);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (754, 'N 750 A', 205);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (755, 'N 750 Za', 205);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (206, 'GSX', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (756, '1250 Fa', 206);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (757, '1300 B-King', 206);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (758, '1300 R Hayabusa', 206);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (759, '1300 Ra Hayabusa', 206);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (760, '1300 Raz Hayabusa', 206);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (761, '650 F', 206);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (762, '750 F', 206);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (207, 'GSX-R', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (763, '1000', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (764, '1000 185Cv', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (765, '1000 A 202Cv', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (766, '1000 A Moto Gp 185Cv', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (767, '1000 Moto Gp 185Cv', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (768, '1000 R 202Cv', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (769, '1000 Raz 202Cv', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (770, '1100 W', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (771, '1300 Hayabusa 197Cv', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (772, '600', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (773, '750 Moto Gp', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (774, '750 W', 207);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (775, '750 W Srad', 207);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (208, 'GSX-S', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (776, '1000 A', 208);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (777, '1000 Az', 208);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (778, '1000 Fa', 208);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (779, '1000 Ya', 208);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (780, '750 A', 208);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (781, '750 Az', 208);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (209, 'Gladius', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (782, 'N650', 209);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (210, 'Inazuma', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (783, '250', 210);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (211, 'Intruder', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (784, '125', 211);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (785, '125 Ed', 211);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (786, '1400 Vs Glp', 211);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (787, '1500 Lc', 211);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (788, '250 Vs', 211);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (789, '800 Vs Glp', 211);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (212, 'Marauder', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (790, '800', 212);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (213, 'RF', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (791, '900 R', 213);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (214, 'RM', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (792, '250', 214);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (215, 'RMX', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (793, '250', 215);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (216, 'SV', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (794, '650 A', 216);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (217, 'Savage', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (795, 'Ls 650', 217);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (218, 'TL', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (796, '1000 S', 218);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (219, 'V-Strom', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (797, '1000', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (798, '1000 A', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (799, '1000 Ad', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (800, '1000 Xt', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (801, '1050 Xt', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (802, '650 A', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (803, '650 Ad', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (804, '650 Xt', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (805, '650 Xt Adventure', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (806, 'Dl 1000', 219);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (807, 'Dl 650', 219);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (220, 'VX', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (808, '800', 220);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (221, 'Yes', 15);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (809, 'En 125', 221);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (222, 'Adventurer', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (810, '900', 222);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (223, 'Bobber', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (811, '1200', 223);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (224, 'Bonneville', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (812, 'T100', 224);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (813, 'T100 Black', 224);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (814, 'T120', 224);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (815, 'T120 Black', 224);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (225, 'Daytona', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (816, '675', 225);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (817, '675 R', 225);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (818, '955I', 225);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (226, 'Rocket III', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (819, '2300', 226);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (820, 'Classic 2300', 226);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (821, 'R 2500', 226);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (822, 'R Black Edition 2500', 226);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (823, 'Roadster 2300', 226);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (227, 'Scrambler', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (824, '865', 227);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (825, 'Xc 1200', 227);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (826, 'Xe 1200', 227);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (228, 'Speed Triple', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (827, '1050', 228);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (828, '1050I', 228);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (829, '900', 228);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (830, 'R 1050', 228);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (229, 'Speed Twin', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (831, '1200', 229);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (230, 'Sprint', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (832, '900', 230);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (833, 'St 1050', 230);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (231, 'Street Cup', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (834, '900', 231);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (232, 'Street Scrambler', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (835, '900', 232);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (233, 'Street Triple', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (836, '675', 233);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (837, '675 Abs', 233);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (838, 'R 675 Abs', 233);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (839, 'Rs 765', 233);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (840, 'S 765', 233);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (234, 'Street Twin', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (841, '900', 234);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (235, 'Thunderbird', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (842, '900', 235);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (843, 'Commander 1700', 235);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (236, 'Tiger 1200', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (844, 'Alpine Edition', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (845, 'Desert Edition', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (846, 'Explorer Xc', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (847, 'Explorer Xca', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (848, 'Explorer Xcx', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (849, 'Explorer Xr', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (850, 'Gt Explorer', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (851, 'Rally Explorer', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (852, 'Rally Pro', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (853, 'Xca', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (854, 'Xcx', 236);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (855, 'Xr', 236);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (237, 'Tiger 800', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (856, 'Std', 237);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (857, 'Xc', 237);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (858, 'Xca', 237);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (859, 'Xcx', 237);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (860, 'Xr', 237);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (861, 'Xrt', 237);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (862, 'Xrx', 237);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (863, 'Xrx Low Seat', 237);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (238, 'Tiger 900', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (864, 'Gt', 238);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (865, 'Gt Low', 238);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (866, 'Gt Pro', 238);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (867, 'Rally', 238);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (868, 'Rally Pro', 238);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (869, 'S 955I', 238);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (870, 'Std', 238);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (239, 'Tiger Sport', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (871, '1050', 239);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (872, '660', 239);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (240, 'Trident', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (873, '660', 240);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (241, 'Trophy', 16);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (874, '1200', 241);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (242, 'EV1', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (875, 'Sport 3000W', 242);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (243, 'EVS', 17);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (876, '3000W', 243);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (244, 'Crypton', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (877, '115 Ed', 244);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (878, '115 K', 244);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (245, 'DT', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (879, '180 Z Trail', 245);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (880, '200', 245);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (881, '200 R', 245);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (246, 'Drag Star', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (882, '650', 246);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (247, 'FZ1', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (883, '1000', 247);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (248, 'FZ6 Fazer', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (884, 'Fz6 N', 248);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (249, 'FZ6-S', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (885, '600', 249);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (250, 'FZ8-N', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (886, '800', 250);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (251, 'FZR 1000', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (887, 'Std', 251);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (252, 'Factor', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (888, '150 E', 252);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (889, '150 Ed', 252);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (890, '150 Ed Ubs', 252);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (891, 'Ybr 125 E', 252);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (892, 'Ybr 125I Ed', 252);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (253, 'Fazer 150', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (893, 'Fz15 Abs', 253);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (894, 'Ubs', 253);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (254, 'Fazer 250', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (895, 'Fz25', 254);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (896, 'Fz25 Le Pantera Negra', 254);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (897, 'Ie Limited Edition', 254);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (898, 'Le Black Edition', 254);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (255, 'Fluo', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (899, '125 Abs', 255);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (256, 'Jog', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (900, '50', 256);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (257, 'MT-01', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (901, '1670', 257);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (258, 'MT-03', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (902, '321', 258);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (903, '321 Abs', 258);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (904, '321 Homem De Ferro Abs', 258);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (905, '660', 258);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (259, 'MT-07', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (906, '690', 259);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (907, '690 Abs', 259);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (260, 'MT-09', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (908, '850', 260);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (909, 'Tracer 850', 260);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (261, 'Neo', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (910, '115 At', 261);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (911, '125 Cvt', 261);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (912, '125 Ubs', 261);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (262, 'Nmax', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (913, '150', 262);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (914, '160', 262);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (915, 'Star Wars Alianca Rebelde 160', 262);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (916, 'Star Wars Imperio Galactico 160', 262);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (263, 'RD 135', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (917, 'Std', 263);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (264, 'RD 350', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (918, 'Lc', 264);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (265, 'RDZ 135', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (919, 'Std', 265);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (266, 'Royal Star 1300', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (920, 'Std', 266);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (267, 'TDM 850', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (921, 'Std', 267);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (268, 'TDM 900', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (922, 'Std', 268);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (269, 'TDR 180', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (923, 'Std', 269);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (270, 'TT-R', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (924, '125 Le', 270);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (925, '230', 270);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (271, 'Tmax', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (926, '530', 271);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (272, 'Tracer', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (927, '900 Gt', 272);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (273, 'VMax', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (928, '1200', 273);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (274, 'Virago', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (929, '750', 274);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (275, 'WR 250', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (930, 'F', 275);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (276, 'WR 450', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (931, 'F', 276);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (277, 'XJ6-F', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (932, '600', 277);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (278, 'XJ6-N', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (933, '600', 278);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (934, '600 Abs', 278);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (279, 'XT 1200Z', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (935, 'Super Tenere', 279);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (936, 'Super Tenere 60Th Anniversary', 279);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (937, 'Super Tenere Dx', 279);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (280, 'XT 225', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (938, 'Std', 280);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (281, 'XT 600', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (939, 'E', 281);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (940, 'Z Tenere', 281);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (282, 'XT 660', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (941, 'R', 282);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (942, 'Z Tenere', 282);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (283, 'XTZ 125', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (943, 'E', 283);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (944, 'K', 283);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (945, 'X/E', 283);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (284, 'XTZ 150', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (946, 'Crosser E', 284);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (947, 'Crosser Ed', 284);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (948, 'Crosser S', 284);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (949, 'Crosser S Abs', 284);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (950, 'Crosser Z', 284);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (951, 'Crosser Z Abs', 284);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (285, 'XTZ 250', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (952, 'Lander', 285);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (953, 'Lander', 285);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (954, 'Lander Le Capitao America', 285);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (955, 'Tenere', 285);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (956, 'Tenere Blueflex', 285);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (957, 'X', 285);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (286, 'XTZ 750', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (958, 'Super Tenere', 286);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (287, 'XV', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (959, '1100 Virago', 287);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (960, '250 Virago', 287);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (961, '535 S Virago', 287);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (288, 'XVS 650', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (962, 'Drag Star', 288);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (289, 'XVS 950 A', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (963, 'Midnight Star', 289);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (290, 'Xmax', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (964, '250', 290);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (291, 'YBR 125 Factor', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (965, 'E', 291);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (966, 'Ed', 291);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (967, 'Ed Limited Edition', 291);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (968, 'K', 291);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (969, 'K1', 291);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (292, 'YS 150', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (970, 'Fazer Ed', 292);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (971, 'Fazer Sed', 292);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (293, 'YS 250', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (972, 'Fazer', 293);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (973, 'Fazer Blueflex', 293);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (294, 'YZ', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (974, '125', 294);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (975, '250', 294);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (976, '250 F', 294);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (977, '450 F', 294);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (978, '65', 294);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (979, '85 Lw', 294);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (295, 'YZF', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (980, '1000 Thunderace', 295);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (296, 'YZF R1', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (981, '1000', 296);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (982, '1000 174Cv', 296);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (983, '1000 Limited Edition', 296);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (297, 'YZF R3', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (984, '321', 297);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (985, '321 Abs', 297);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (986, '321 Monster Energy Moto Gp Edition', 297);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (987, 'World Gp 60Th Anniversary Edition', 297);

INSERT INTO motorcycle_brand_models (id, model, brand_id) VALUES (298, 'YZF R6', 18);
INSERT INTO motorcycle_brand_models_versions (id, version, model_id) VALUES (988, '600', 298);