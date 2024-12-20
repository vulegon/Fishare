module TestData
  module FishingSpots
    class Datasets
      class << self
        def load
          fishing_spots = [
            {'prefecture': '北海道', 'name': '北海道釣り場1', 'description': '北海道の人気釣りスポット1', 'latitude': 43.0742, 'longitude': 141.3569, 'address': '北海道市釣り場1'},
            {'prefecture': '北海道', 'name': '北海道釣り場2', 'description': '北海道の人気釣りスポット2', 'latitude': 43.0842, 'longitude': 141.3669, 'address': '北海道市釣り場2'},
            {'prefecture': '北海道', 'name': '北海道釣り場3', 'description': '北海道の人気釣りスポット3', 'latitude': 43.0942, 'longitude': 141.3769, 'address': '北海道市釣り場3'},
            {'prefecture': '北海道', 'name': '北海道釣り場4', 'description': '北海道の人気釣りスポット4', 'latitude': 43.1042, 'longitude': 141.3869, 'address': '北海道市釣り場4'},
            {'prefecture': '北海道', 'name': '北海道釣り場5', 'description': '北海道の人気釣りスポット5', 'latitude': 43.1142, 'longitude': 141.3969, 'address': '北海道市釣り場5'},
            {'prefecture': '青森県', 'name': '青森県釣り場1', 'description': '青森県の人気釣りスポット1', 'latitude': 40.8344, 'longitude': 140.75, 'address': '青森県市釣り場1'},
            {'prefecture': '青森県', 'name': '青森県釣り場2', 'description': '青森県の人気釣りスポット2', 'latitude': 40.8444, 'longitude': 140.76, 'address': '青森県市釣り場2'},
            {'prefecture': '青森県', 'name': '青森県釣り場3', 'description': '青森県の人気釣りスポット3', 'latitude': 40.8544, 'longitude': 140.77, 'address': '青森県市釣り場3'},
            {'prefecture': '青森県', 'name': '青森県釣り場4', 'description': '青森県の人気釣りスポット4', 'latitude': 40.8644, 'longitude': 140.78, 'address': '青森県市釣り場4'},
            {'prefecture': '青森県', 'name': '青森県釣り場5', 'description': '青森県の人気釣りスポット5', 'latitude': 40.8744, 'longitude': 140.79, 'address': '青森県市釣り場5'},
            {'prefecture': '岩手県', 'name': '岩手県釣り場1', 'description': '岩手県の人気釣りスポット1', 'latitude': 39.7136, 'longitude': 141.1627, 'address': '岩手県市釣り場1'},
            {'prefecture': '岩手県', 'name': '岩手県釣り場2', 'description': '岩手県の人気釣りスポット2', 'latitude': 39.7236, 'longitude': 141.1727, 'address': '岩手県市釣り場2'},
            {'prefecture': '岩手県', 'name': '岩手県釣り場3', 'description': '岩手県の人気釣りスポット3', 'latitude': 39.7336, 'longitude': 141.1827, 'address': '岩手県市釣り場3'},
            {'prefecture': '岩手県', 'name': '岩手県釣り場4', 'description': '岩手県の人気釣りスポット4', 'latitude': 39.7436, 'longitude': 141.1927, 'address': '岩手県市釣り場4'},
            {'prefecture': '岩手県', 'name': '岩手県釣り場5', 'description': '岩手県の人気釣りスポット5', 'latitude': 39.7536, 'longitude': 141.2027, 'address': '岩手県市釣り場5'},
            {'prefecture': '宮城県', 'name': '宮城県釣り場1', 'description': '宮城県の人気釣りスポット1', 'latitude': 38.2788, 'longitude': 140.8821, 'address': '宮城県市釣り場1'},
            {'prefecture': '宮城県', 'name': '宮城県釣り場2', 'description': '宮城県の人気釣りスポット2', 'latitude': 38.2888, 'longitude': 140.8921, 'address': '宮城県市釣り場2'},
            {'prefecture': '宮城県', 'name': '宮城県釣り場3', 'description': '宮城県の人気釣りスポット3', 'latitude': 38.2988, 'longitude': 140.9021, 'address': '宮城県市釣り場3'},
            {'prefecture': '宮城県', 'name': '宮城県釣り場4', 'description': '宮城県の人気釣りスポット4', 'latitude': 38.3088, 'longitude': 140.9121, 'address': '宮城県市釣り場4'},
            {'prefecture': '宮城県', 'name': '宮城県釣り場5', 'description': '宮城県の人気釣りスポット5', 'latitude': 38.3188, 'longitude': 140.9221, 'address': '宮城県市釣り場5'},
            {'prefecture': '秋田県', 'name': '秋田県釣り場1', 'description': '秋田県の人気釣りスポット1', 'latitude': 39.7286, 'longitude': 140.1123, 'address': '秋田県市釣り場1'},
            {'prefecture': '秋田県', 'name': '秋田県釣り場2', 'description': '秋田県の人気釣りスポット2', 'latitude': 39.7386, 'longitude': 140.1223, 'address': '秋田県市釣り場2'},
            {'prefecture': '秋田県', 'name': '秋田県釣り場3', 'description': '秋田県の人気釣りスポット3', 'latitude': 39.7486, 'longitude': 140.1323, 'address': '秋田県市釣り場3'},
            {'prefecture': '秋田県', 'name': '秋田県釣り場4', 'description': '秋田県の人気釣りスポット4', 'latitude': 39.7586, 'longitude': 140.1423, 'address': '秋田県市釣り場4'},
            {'prefecture': '秋田県', 'name': '秋田県釣り場5', 'description': '秋田県の人気釣りスポット5', 'latitude': 39.7686, 'longitude': 140.1523, 'address': '秋田県市釣り場5'},
            {'prefecture': '山形県', 'name': '山形県釣り場1', 'description': '山形県の人気釣りスポット1', 'latitude': 38.2504, 'longitude': 140.3733, 'address': '山形県市釣り場1'},
            {'prefecture': '山形県', 'name': '山形県釣り場2', 'description': '山形県の人気釣りスポット2', 'latitude': 38.2604, 'longitude': 140.3833, 'address': '山形県市釣り場2'},
            {'prefecture': '山形県', 'name': '山形県釣り場3', 'description': '山形県の人気釣りスポット3', 'latitude': 38.2704, 'longitude': 140.3933, 'address': '山形県市釣り場3'},
            {'prefecture': '山形県', 'name': '山形県釣り場4', 'description': '山形県の人気釣りスポット4', 'latitude': 38.2804, 'longitude': 140.4033, 'address': '山形県市釣り場4'},
            {'prefecture': '山形県', 'name': '山形県釣り場5', 'description': '山形県の人気釣りスポット5', 'latitude': 38.2904, 'longitude': 140.4133, 'address': '山形県市釣り場5'},
            {'prefecture': '福島県', 'name': '福島県釣り場1', 'description': '福島県の人気釣りスポット1', 'latitude': 37.7603, 'longitude': 140.4775, 'address': '福島県市釣り場1'},
            {'prefecture': '福島県', 'name': '福島県釣り場2', 'description': '福島県の人気釣りスポット2', 'latitude': 37.7703, 'longitude': 140.4875, 'address': '福島県市釣り場2'},
            {'prefecture': '福島県', 'name': '福島県釣り場3', 'description': '福島県の人気釣りスポット3', 'latitude': 37.7803, 'longitude': 140.4975, 'address': '福島県市釣り場3'},
            {'prefecture': '福島県', 'name': '福島県釣り場4', 'description': '福島県の人気釣りスポット4', 'latitude': 37.7903, 'longitude': 140.5075, 'address': '福島県市釣り場4'},
            {'prefecture': '福島県', 'name': '福島県釣り場5', 'description': '福島県の人気釣りスポット5', 'latitude': 37.8003, 'longitude': 140.5175, 'address': '福島県市釣り場5'},
            {'prefecture': '茨城県', 'name': '茨城県釣り場1', 'description': '茨城県の人気釣りスポット1', 'latitude': 36.3518, 'longitude': 140.4568, 'address': '茨城県市釣り場1'},
            {'prefecture': '茨城県', 'name': '茨城県釣り場2', 'description': '茨城県の人気釣りスポット2', 'latitude': 36.3618, 'longitude': 140.4668, 'address': '茨城県市釣り場2'},
            {'prefecture': '茨城県', 'name': '茨城県釣り場3', 'description': '茨城県の人気釣りスポット3', 'latitude': 36.3718, 'longitude': 140.4768, 'address': '茨城県市釣り場3'},
            {'prefecture': '茨城県', 'name': '茨城県釣り場4', 'description': '茨城県の人気釣りスポット4', 'latitude': 36.3818, 'longitude': 140.4868, 'address': '茨城県市釣り場4'},
            {'prefecture': '茨城県', 'name': '茨城県釣り場5', 'description': '茨城県の人気釣りスポット5', 'latitude': 36.3918, 'longitude': 140.4968, 'address': '茨城県市釣り場5'},
            {'prefecture': '栃木県', 'name': '栃木県釣り場1', 'description': '栃木県の人気釣りスポット1', 'latitude': 36.5757, 'longitude': 139.8936, 'address': '栃木県市釣り場1'},
            {'prefecture': '栃木県', 'name': '栃木県釣り場2', 'description': '栃木県の人気釣りスポット2', 'latitude': 36.5857, 'longitude': 139.9036, 'address': '栃木県市釣り場2'},
            {'prefecture': '栃木県', 'name': '栃木県釣り場3', 'description': '栃木県の人気釣りスポット3', 'latitude': 36.5957, 'longitude': 139.9136, 'address': '栃木県市釣り場3'},
            {'prefecture': '栃木県', 'name': '栃木県釣り場4', 'description': '栃木県の人気釣りスポット4', 'latitude': 36.6057, 'longitude': 139.9236, 'address': '栃木県市釣り場4'},
            {'prefecture': '栃木県', 'name': '栃木県釣り場5', 'description': '栃木県の人気釣りスポット5', 'latitude': 36.6157, 'longitude': 139.9336, 'address': '栃木県市釣り場5'},
            {'prefecture': '群馬県', 'name': '群馬県釣り場1', 'description': '群馬県の人気釣りスポット1', 'latitude': 36.4007, 'longitude': 139.0704, 'address': '群馬県市釣り場1'},
            {'prefecture': '群馬県', 'name': '群馬県釣り場2', 'description': '群馬県の人気釣りスポット2', 'latitude': 36.4107, 'longitude': 139.0804, 'address': '群馬県市釣り場2'},
            {'prefecture': '群馬県', 'name': '群馬県釣り場3', 'description': '群馬県の人気釣りスポット3', 'latitude': 36.4207, 'longitude': 139.0904, 'address': '群馬県市釣り場3'},
            {'prefecture': '群馬県', 'name': '群馬県釣り場4', 'description': '群馬県の人気釣りスポット4', 'latitude': 36.4307, 'longitude': 139.1004, 'address': '群馬県市釣り場4'},
            {'prefecture': '群馬県', 'name': '群馬県釣り場5', 'description': '群馬県の人気釣りスポット5', 'latitude': 36.4407, 'longitude': 139.1104, 'address': '群馬県市釣り場5'},
            {'prefecture': '埼玉県', 'name': '埼玉県釣り場1', 'description': '埼玉県の人気釣りスポット1', 'latitude': 35.8674, 'longitude': 139.6589, 'address': '埼玉県市釣り場1'},
            {'prefecture': '埼玉県', 'name': '埼玉県釣り場2', 'description': '埼玉県の人気釣りスポット2', 'latitude': 35.8774, 'longitude': 139.6689, 'address': '埼玉県市釣り場2'},
            {'prefecture': '埼玉県', 'name': '埼玉県釣り場3', 'description': '埼玉県の人気釣りスポット3', 'latitude': 35.8874, 'longitude': 139.6789, 'address': '埼玉県市釣り場3'},
            {'prefecture': '埼玉県', 'name': '埼玉県釣り場4', 'description': '埼玉県の人気釣りスポット4', 'latitude': 35.8974, 'longitude': 139.6889, 'address': '埼玉県市釣り場4'},
            {'prefecture': '埼玉県', 'name': '埼玉県釣り場5', 'description': '埼玉県の人気釣りスポット5', 'latitude': 35.9074, 'longitude': 139.6989, 'address': '埼玉県市釣り場5'},
            {'prefecture': '千葉県', 'name': '千葉県釣り場1', 'description': '千葉県の人気釣りスポット1', 'latitude': 35.6173, 'longitude': 140.1163, 'address': '千葉県市釣り場1'},
            {'prefecture': '千葉県', 'name': '千葉県釣り場2', 'description': '千葉県の人気釣りスポット2', 'latitude': 35.6273, 'longitude': 140.1263, 'address': '千葉県市釣り場2'},
            {'prefecture': '千葉県', 'name': '千葉県釣り場3', 'description': '千葉県の人気釣りスポット3', 'latitude': 35.6373, 'longitude': 140.1363, 'address': '千葉県市釣り場3'},
            {'prefecture': '千葉県', 'name': '千葉県釣り場4', 'description': '千葉県の人気釣りスポット4', 'latitude': 35.6473, 'longitude': 140.1463, 'address': '千葉県市釣り場4'},
            {'prefecture': '千葉県', 'name': '千葉県釣り場5', 'description': '千葉県の人気釣りスポット5', 'latitude': 35.6573, 'longitude': 140.1563, 'address': '千葉県市釣り場5'},
            {'prefecture': '東京都', 'name': '東京都釣り場1', 'description': '東京都の人気釣りスポット1', 'latitude': 35.6995, 'longitude': 139.7017, 'address': '東京都市釣り場1'},
            {'prefecture': '東京都', 'name': '東京都釣り場2', 'description': '東京都の人気釣りスポット2', 'latitude': 35.7095, 'longitude': 139.7117, 'address': '東京都市釣り場2'},
            {'prefecture': '東京都', 'name': '東京都釣り場3', 'description': '東京都の人気釣りスポット3', 'latitude': 35.7195, 'longitude': 139.7217, 'address': '東京都市釣り場3'},
            {'prefecture': '東京都', 'name': '東京都釣り場4', 'description': '東京都の人気釣りスポット4', 'latitude': 35.7295, 'longitude': 139.7317, 'address': '東京都市釣り場4'},
            {'prefecture': '東京都', 'name': '東京都釣り場5', 'description': '東京都の人気釣りスポット5', 'latitude': 35.7395, 'longitude': 139.7417, 'address': '東京都市釣り場5'},
            {'prefecture': '神奈川県', 'name': '神奈川県釣り場1', 'description': '神奈川県の人気釣りスポット1', 'latitude': 35.4575, 'longitude': 139.6525, 'address': '神奈川県市釣り場1'},
            {'prefecture': '神奈川県', 'name': '神奈川県釣り場2', 'description': '神奈川県の人気釣りスポット2', 'latitude': 35.4675, 'longitude': 139.6625, 'address': '神奈川県市釣り場2'},
            {'prefecture': '神奈川県', 'name': '神奈川県釣り場3', 'description': '神奈川県の人気釣りスポット3', 'latitude': 35.4775, 'longitude': 139.6725, 'address': '神奈川県市釣り場3'},
            {'prefecture': '神奈川県', 'name': '神奈川県釣り場4', 'description': '神奈川県の人気釣りスポット4', 'latitude': 35.4875, 'longitude': 139.6825, 'address': '神奈川県市釣り場4'},
            {'prefecture': '神奈川県', 'name': '神奈川県釣り場5', 'description': '神奈川県の人気釣りスポット5', 'latitude': 35.4975, 'longitude': 139.6925, 'address': '神奈川県市釣り場5'},
            {'prefecture': '新潟県', 'name': '新潟県釣り場1', 'description': '新潟県の人気釣りスポット1', 'latitude': 37.9124, 'longitude': 139.0332, 'address': '新潟県市釣り場1'},
            {'prefecture': '新潟県', 'name': '新潟県釣り場2', 'description': '新潟県の人気釣りスポット2', 'latitude': 37.9224, 'longitude': 139.0432, 'address': '新潟県市釣り場2'},
            {'prefecture': '新潟県', 'name': '新潟県釣り場3', 'description': '新潟県の人気釣りスポット3', 'latitude': 37.9324, 'longitude': 139.0532, 'address': '新潟県市釣り場3'},
            {'prefecture': '新潟県', 'name': '新潟県釣り場4', 'description': '新潟県の人気釣りスポット4', 'latitude': 37.9424, 'longitude': 139.0632, 'address': '新潟県市釣り場4'},
            {'prefecture': '新潟県', 'name': '新潟県釣り場5', 'description': '新潟県の人気釣りスポット5', 'latitude': 37.9524, 'longitude': 139.0732, 'address': '新潟県市釣り場5'},
            {'prefecture': '富山県', 'name': '富山県釣り場1', 'description': '富山県の人気釣りスポット1', 'latitude': 36.7053, 'longitude': 137.2213, 'address': '富山県市釣り場1'},
            {'prefecture': '富山県', 'name': '富山県釣り場2', 'description': '富山県の人気釣りスポット2', 'latitude': 36.7153, 'longitude': 137.2313, 'address': '富山県市釣り場2'},
            {'prefecture': '富山県', 'name': '富山県釣り場3', 'description': '富山県の人気釣りスポット3', 'latitude': 36.7253, 'longitude': 137.2413, 'address': '富山県市釣り場3'},
            {'prefecture': '富山県', 'name': '富山県釣り場4', 'description': '富山県の人気釣りスポット4', 'latitude': 36.7353, 'longitude': 137.2513, 'address': '富山県市釣り場4'},
            {'prefecture': '富山県', 'name': '富山県釣り場5', 'description': '富山県の人気釣りスポット5', 'latitude': 36.7453, 'longitude': 137.2613, 'address': '富山県市釣り場5'},
            {'prefecture': '石川県', 'name': '石川県釣り場1', 'description': '石川県の人気釣りスポット1', 'latitude': 36.6047, 'longitude': 136.6356, 'address': '石川県市釣り場1'},
            {'prefecture': '石川県', 'name': '石川県釣り場2', 'description': '石川県の人気釣りスポット2', 'latitude': 36.6147, 'longitude': 136.6456, 'address': '石川県市釣り場2'},
            {'prefecture': '石川県', 'name': '石川県釣り場3', 'description': '石川県の人気釣りスポット3', 'latitude': 36.6247, 'longitude': 136.6556, 'address': '石川県市釣り場3'},
            {'prefecture': '石川県', 'name': '石川県釣り場4', 'description': '石川県の人気釣りスポット4', 'latitude': 36.6347, 'longitude': 136.6656, 'address': '石川県市釣り場4'},
            {'prefecture': '石川県', 'name': '石川県釣り場5', 'description': '石川県の人気釣りスポット5', 'latitude': 36.6447, 'longitude': 136.6756, 'address': '石川県市釣り場5'},
            {'prefecture': '福井県', 'name': '福井県釣り場1', 'description': '福井県の人気釣りスポット1', 'latitude': 36.0752, 'longitude': 136.2316, 'address': '福井県市釣り場1'},
            {'prefecture': '福井県', 'name': '福井県釣り場2', 'description': '福井県の人気釣りスポット2', 'latitude': 36.0852, 'longitude': 136.2416, 'address': '福井県市釣り場2'},
            {'prefecture': '福井県', 'name': '福井県釣り場3', 'description': '福井県の人気釣りスポット3', 'latitude': 36.0952, 'longitude': 136.2516, 'address': '福井県市釣り場3'},
            {'prefecture': '福井県', 'name': '福井県釣り場4', 'description': '福井県の人気釣りスポット4', 'latitude': 36.1052, 'longitude': 136.2616, 'address': '福井県市釣り場4'},
            {'prefecture': '福井県', 'name': '福井県釣り場5', 'description': '福井県の人気釣りスポット5', 'latitude': 36.1152, 'longitude': 136.2716, 'address': '福井県市釣り場5'},
            {'prefecture': '山梨県', 'name': '山梨県釣り場1', 'description': '山梨県の人気釣りスポット1', 'latitude': 35.6742, 'longitude': 138.5785, 'address': '山梨県市釣り場1'},
            {'prefecture': '山梨県', 'name': '山梨県釣り場2', 'description': '山梨県の人気釣りスポット2', 'latitude': 35.6842, 'longitude': 138.5885, 'address': '山梨県市釣り場2'},
            {'prefecture': '山梨県', 'name': '山梨県釣り場3', 'description': '山梨県の人気釣りスポット3', 'latitude': 35.6942, 'longitude': 138.5985, 'address': '山梨県市釣り場3'},
            {'prefecture': '山梨県', 'name': '山梨県釣り場4', 'description': '山梨県の人気釣りスポット4', 'latitude': 35.7042, 'longitude': 138.6085, 'address': '山梨県市釣り場4'},
            {'prefecture': '山梨県', 'name': '山梨県釣り場5', 'description': '山梨県の人気釣りスポット5', 'latitude': 35.7142, 'longitude': 138.6185, 'address': '山梨県市釣り場5'},
            {'prefecture': '長野県', 'name': '長野県釣り場1', 'description': '長野県の人気釣りスポット1', 'latitude': 36.6613, 'longitude': 138.1909, 'address': '長野県市釣り場1'},
            {'prefecture': '長野県', 'name': '長野県釣り場2', 'description': '長野県の人気釣りスポット2', 'latitude': 36.6713, 'longitude': 138.2009, 'address': '長野県市釣り場2'},
            {'prefecture': '長野県', 'name': '長野県釣り場3', 'description': '長野県の人気釣りスポット3', 'latitude': 36.6813, 'longitude': 138.2109, 'address': '長野県市釣り場3'},
            {'prefecture': '長野県', 'name': '長野県釣り場4', 'description': '長野県の人気釣りスポット4', 'latitude': 36.6913, 'longitude': 138.2209, 'address': '長野県市釣り場4'},
            {'prefecture': '長野県', 'name': '長野県釣り場5', 'description': '長野県の人気釣りスポット5', 'latitude': 36.7013, 'longitude': 138.2309, 'address': '長野県市釣り場5'},
            {'prefecture': '岐阜県', 'name': '岐阜県釣り場1', 'description': '岐阜県の人気釣りスポット1', 'latitude': 35.4012, 'longitude': 136.7323, 'address': '岐阜県市釣り場1'},
            {'prefecture': '岐阜県', 'name': '岐阜県釣り場2', 'description': '岐阜県の人気釣りスポット2', 'latitude': 35.4112, 'longitude': 136.7423, 'address': '岐阜県市釣り場2'},
            {'prefecture': '岐阜県', 'name': '岐阜県釣り場3', 'description': '岐阜県の人気釣りスポット3', 'latitude': 35.4212, 'longitude': 136.7523, 'address': '岐阜県市釣り場3'},
            {'prefecture': '岐阜県', 'name': '岐阜県釣り場4', 'description': '岐阜県の人気釣りスポット4', 'latitude': 35.4312, 'longitude': 136.7623, 'address': '岐阜県市釣り場4'},
            {'prefecture': '岐阜県', 'name': '岐阜県釣り場5', 'description': '岐阜県の人気釣りスポット5', 'latitude': 35.4412, 'longitude': 136.7723, 'address': '岐阜県市釣り場5'},
            {'prefecture': '静岡県', 'name': '静岡県釣り場1', 'description': '静岡県の人気釣りスポット1', 'latitude': 34.9869, 'longitude': 138.3931, 'address': '静岡県市釣り場1'},
            {'prefecture': '静岡県', 'name': '静岡県釣り場2', 'description': '静岡県の人気釣りスポット2', 'latitude': 34.9969, 'longitude': 138.4031, 'address': '静岡県市釣り場2'},
            {'prefecture': '静岡県', 'name': '静岡県釣り場3', 'description': '静岡県の人気釣りスポット3', 'latitude': 35.0069, 'longitude': 138.4131, 'address': '静岡県市釣り場3'},
            {'prefecture': '静岡県', 'name': '静岡県釣り場4', 'description': '静岡県の人気釣りスポット4', 'latitude': 35.0169, 'longitude': 138.4231, 'address': '静岡県市釣り場4'},
            {'prefecture': '静岡県', 'name': '静岡県釣り場5', 'description': '静岡県の人気釣りスポット5', 'latitude': 35.0269, 'longitude': 138.4331, 'address': '静岡県市釣り場5'},
            {'prefecture': '愛知県', 'name': '愛知県釣り場1', 'description': '愛知県の人気釣りスポット1', 'latitude': 35.1902, 'longitude': 136.9166, 'address': '愛知県市釣り場1'},
            {'prefecture': '愛知県', 'name': '愛知県釣り場2', 'description': '愛知県の人気釣りスポット2', 'latitude': 35.2002, 'longitude': 136.9266, 'address': '愛知県市釣り場2'},
            {'prefecture': '愛知県', 'name': '愛知県釣り場3', 'description': '愛知県の人気釣りスポット3', 'latitude': 35.2102, 'longitude': 136.9366, 'address': '愛知県市釣り場3'},
            {'prefecture': '愛知県', 'name': '愛知県釣り場4', 'description': '愛知県の人気釣りスポット4', 'latitude': 35.2202, 'longitude': 136.9466, 'address': '愛知県市釣り場4'},
            {'prefecture': '愛知県', 'name': '愛知県釣り場5', 'description': '愛知県の人気釣りスポット5', 'latitude': 35.2302, 'longitude': 136.9566, 'address': '愛知県市釣り場5'},
            {'prefecture': '三重県', 'name': '三重県釣り場1', 'description': '三重県の人気釣りスポット1', 'latitude': 34.7403, 'longitude': 136.5186, 'address': '三重県市釣り場1'},
            {'prefecture': '三重県', 'name': '三重県釣り場2', 'description': '三重県の人気釣りスポット2', 'latitude': 34.7503, 'longitude': 136.5286, 'address': '三重県市釣り場2'},
            {'prefecture': '三重県', 'name': '三重県釣り場3', 'description': '三重県の人気釣りスポット3', 'latitude': 34.7603, 'longitude': 136.5386, 'address': '三重県市釣り場3'},
            {'prefecture': '三重県', 'name': '三重県釣り場4', 'description': '三重県の人気釣りスポット4', 'latitude': 34.7703, 'longitude': 136.5486, 'address': '三重県市釣り場4'},
            {'prefecture': '三重県', 'name': '三重県釣り場5', 'description': '三重県の人気釣りスポット5', 'latitude': 34.7803, 'longitude': 136.5586, 'address': '三重県市釣り場5'},
            {'prefecture': '滋賀県', 'name': '滋賀県釣り場1', 'description': '滋賀県の人気釣りスポット1', 'latitude': 35.0145, 'longitude': 135.8786, 'address': '滋賀県市釣り場1'},
            {'prefecture': '滋賀県', 'name': '滋賀県釣り場2', 'description': '滋賀県の人気釣りスポット2', 'latitude': 35.0245, 'longitude': 135.8886, 'address': '滋賀県市釣り場2'},
            {'prefecture': '滋賀県', 'name': '滋賀県釣り場3', 'description': '滋賀県の人気釣りスポット3', 'latitude': 35.0345, 'longitude': 135.8986, 'address': '滋賀県市釣り場3'},
            {'prefecture': '滋賀県', 'name': '滋賀県釣り場4', 'description': '滋賀県の人気釣りスポット4', 'latitude': 35.0445, 'longitude': 135.9086, 'address': '滋賀県市釣り場4'},
            {'prefecture': '滋賀県', 'name': '滋賀県釣り場5', 'description': '滋賀県の人気釣りスポット5', 'latitude': 35.0545, 'longitude': 135.9186, 'address': '滋賀県市釣り場5'},
            {'prefecture': '京都府', 'name': '京都府釣り場1', 'description': '京都府の人気釣りスポット1', 'latitude': 35.0216, 'longitude': 135.7781, 'address': '京都府市釣り場1'},
            {'prefecture': '京都府', 'name': '京都府釣り場2', 'description': '京都府の人気釣りスポット2', 'latitude': 35.0316, 'longitude': 135.7881, 'address': '京都府市釣り場2'},
            {'prefecture': '京都府', 'name': '京都府釣り場3', 'description': '京都府の人気釣りスポット3', 'latitude': 35.0416, 'longitude': 135.7981, 'address': '京都府市釣り場3'},
            {'prefecture': '京都府', 'name': '京都府釣り場4', 'description': '京都府の人気釣りスポット4', 'latitude': 35.0516, 'longitude': 135.8081, 'address': '京都府市釣り場4'},
            {'prefecture': '京都府', 'name': '京都府釣り場5', 'description': '京都府の人気釣りスポット5', 'latitude': 35.0616, 'longitude': 135.8181, 'address': '京都府市釣り場5'},
            {'prefecture': '大阪府', 'name': '大阪府釣り場1', 'description': '大阪府の人気釣りスポット1', 'latitude': 34.7037, 'longitude': 135.5123, 'address': '大阪府市釣り場1'},
            {'prefecture': '大阪府', 'name': '大阪府釣り場2', 'description': '大阪府の人気釣りスポット2', 'latitude': 34.7137, 'longitude': 135.5223, 'address': '大阪府市釣り場2'},
            {'prefecture': '大阪府', 'name': '大阪府釣り場3', 'description': '大阪府の人気釣りスポット3', 'latitude': 34.7237, 'longitude': 135.5323, 'address': '大阪府市釣り場3'},
            {'prefecture': '大阪府', 'name': '大阪府釣り場4', 'description': '大阪府の人気釣りスポット4', 'latitude': 34.7337, 'longitude': 135.5423, 'address': '大阪府市釣り場4'},
            {'prefecture': '大阪府', 'name': '大阪府釣り場5', 'description': '大阪府の人気釣りスポット5', 'latitude': 34.7437, 'longitude': 135.5523, 'address': '大阪府市釣り場5'},
            {'prefecture': '兵庫県', 'name': '兵庫県釣り場1', 'description': '兵庫県の人気釣りスポット1', 'latitude': 34.7013, 'longitude': 135.193, 'address': '兵庫県市釣り場1'},
            {'prefecture': '兵庫県', 'name': '兵庫県釣り場2', 'description': '兵庫県の人気釣りスポット2', 'latitude': 34.7113, 'longitude': 135.203, 'address': '兵庫県市釣り場2'},
            {'prefecture': '兵庫県', 'name': '兵庫県釣り場3', 'description': '兵庫県の人気釣りスポット3', 'latitude': 34.7213, 'longitude': 135.213, 'address': '兵庫県市釣り場3'},
            {'prefecture': '兵庫県', 'name': '兵庫県釣り場4', 'description': '兵庫県の人気釣りスポット4', 'latitude': 34.7313, 'longitude': 135.223, 'address': '兵庫県市釣り場4'},
            {'prefecture': '兵庫県', 'name': '兵庫県釣り場5', 'description': '兵庫県の人気釣りスポット5', 'latitude': 34.7413, 'longitude': 135.233, 'address': '兵庫県市釣り場5'},
            {'prefecture': '奈良県', 'name': '奈良県釣り場1', 'description': '奈良県の人気釣りスポット1', 'latitude': 34.6951, 'longitude': 135.8148, 'address': '奈良県市釣り場1'},
            {'prefecture': '奈良県', 'name': '奈良県釣り場2', 'description': '奈良県の人気釣りスポット2', 'latitude': 34.7051, 'longitude': 135.8248, 'address': '奈良県市釣り場2'},
            {'prefecture': '奈良県', 'name': '奈良県釣り場3', 'description': '奈良県の人気釣りスポット3', 'latitude': 34.7151, 'longitude': 135.8348, 'address': '奈良県市釣り場3'},
            {'prefecture': '奈良県', 'name': '奈良県釣り場4', 'description': '奈良県の人気釣りスポット4', 'latitude': 34.7251, 'longitude': 135.8448, 'address': '奈良県市釣り場4'},
            {'prefecture': '奈良県', 'name': '奈良県釣り場5', 'description': '奈良県の人気釣りスポット5', 'latitude': 34.7351, 'longitude': 135.8548, 'address': '奈良県市釣り場5'},
            {'prefecture': '和歌山県', 'name': '和歌山県釣り場1', 'description': '和歌山県の人気釣りスポット1', 'latitude': 34.236, 'longitude': 135.1775, 'address': '和歌山県市釣り場1'},
            {'prefecture': '和歌山県', 'name': '和歌山県釣り場2', 'description': '和歌山県の人気釣りスポット2', 'latitude': 34.246, 'longitude': 135.1875, 'address': '和歌山県市釣り場2'},
            {'prefecture': '和歌山県', 'name': '和歌山県釣り場3', 'description': '和歌山県の人気釣りスポット3', 'latitude': 34.256, 'longitude': 135.1975, 'address': '和歌山県市釣り場3'},
            {'prefecture': '和歌山県', 'name': '和歌山県釣り場4', 'description': '和歌山県の人気釣りスポット4', 'latitude': 34.266, 'longitude': 135.2075, 'address': '和歌山県市釣り場4'},
            {'prefecture': '和歌山県', 'name': '和歌山県釣り場5', 'description': '和歌山県の人気釣りスポット5', 'latitude': 34.276, 'longitude': 135.2175, 'address': '和歌山県市釣り場5'},
            {'prefecture': '鳥取県', 'name': '鳥取県釣り場1', 'description': '鳥取県の人気釣りスポット1', 'latitude': 35.5139, 'longitude': 134.2477, 'address': '鳥取県市釣り場1'},
            {'prefecture': '鳥取県', 'name': '鳥取県釣り場2', 'description': '鳥取県の人気釣りスポット2', 'latitude': 35.5239, 'longitude': 134.2577, 'address': '鳥取県市釣り場2'},
            {'prefecture': '鳥取県', 'name': '鳥取県釣り場3', 'description': '鳥取県の人気釣りスポット3', 'latitude': 35.5339, 'longitude': 134.2677, 'address': '鳥取県市釣り場3'},
            {'prefecture': '鳥取県', 'name': '鳥取県釣り場4', 'description': '鳥取県の人気釣りスポット4', 'latitude': 35.5439, 'longitude': 134.2777, 'address': '鳥取県市釣り場4'},
            {'prefecture': '鳥取県', 'name': '鳥取県釣り場5', 'description': '鳥取県の人気釣りスポット5', 'latitude': 35.5539, 'longitude': 134.2877, 'address': '鳥取県市釣り場5'},
            {'prefecture': '島根県', 'name': '島根県釣り場1', 'description': '島根県の人気釣りスポット1', 'latitude': 35.4823, 'longitude': 133.0605, 'address': '島根県市釣り場1'},
            {'prefecture': '島根県', 'name': '島根県釣り場2', 'description': '島根県の人気釣りスポット2', 'latitude': 35.4923, 'longitude': 133.0705, 'address': '島根県市釣り場2'},
            {'prefecture': '島根県', 'name': '島根県釣り場3', 'description': '島根県の人気釣りスポット3', 'latitude': 35.5023, 'longitude': 133.0805, 'address': '島根県市釣り場3'},
            {'prefecture': '島根県', 'name': '島根県釣り場4', 'description': '島根県の人気釣りスポット4', 'latitude': 35.5123, 'longitude': 133.0905, 'address': '島根県市釣り場4'},
            {'prefecture': '島根県', 'name': '島根県釣り場5', 'description': '島根県の人気釣りスポット5', 'latitude': 35.5223, 'longitude': 133.1005, 'address': '島根県市釣り場5'},
            {'prefecture': '岡山県', 'name': '岡山県釣り場1', 'description': '岡山県の人気釣りスポット1', 'latitude': 34.6718, 'longitude': 133.9444, 'address': '岡山県市釣り場1'},
            {'prefecture': '岡山県', 'name': '岡山県釣り場2', 'description': '岡山県の人気釣りスポット2', 'latitude': 34.6818, 'longitude': 133.9544, 'address': '岡山県市釣り場2'},
            {'prefecture': '岡山県', 'name': '岡山県釣り場3', 'description': '岡山県の人気釣りスポット3', 'latitude': 34.6918, 'longitude': 133.9644, 'address': '岡山県市釣り場3'},
            {'prefecture': '岡山県', 'name': '岡山県釣り場4', 'description': '岡山県の人気釣りスポット4', 'latitude': 34.7018, 'longitude': 133.9744, 'address': '岡山県市釣り場4'},
            {'prefecture': '岡山県', 'name': '岡山県釣り場5', 'description': '岡山県の人気釣りスポット5', 'latitude': 34.7118, 'longitude': 133.9844, 'address': '岡山県市釣り場5'},
            {'prefecture': '広島県', 'name': '広島県釣り場1', 'description': '広島県の人気釣りスポット1', 'latitude': 34.3952, 'longitude': 132.4653, 'address': '広島県市釣り場1'},
            {'prefecture': '広島県', 'name': '広島県釣り場2', 'description': '広島県の人気釣りスポット2', 'latitude': 34.4052, 'longitude': 132.4753, 'address': '広島県市釣り場2'},
            {'prefecture': '広島県', 'name': '広島県釣り場3', 'description': '広島県の人気釣りスポット3', 'latitude': 34.4152, 'longitude': 132.4853, 'address': '広島県市釣り場3'},
            {'prefecture': '広島県', 'name': '広島県釣り場4', 'description': '広島県の人気釣りスポット4', 'latitude': 34.4252, 'longitude': 132.4953, 'address': '広島県市釣り場4'},
            {'prefecture': '広島県', 'name': '広島県釣り場5', 'description': '広島県の人気釣りスポット5', 'latitude': 34.4352, 'longitude': 132.5053, 'address': '広島県市釣り場5'},
            {'prefecture': '山口県', 'name': '山口県釣り場1', 'description': '山口県の人気釣りスポット1', 'latitude': 34.1959, 'longitude': 131.4814, 'address': '山口県市釣り場1'},
            {'prefecture': '山口県', 'name': '山口県釣り場2', 'description': '山口県の人気釣りスポット2', 'latitude': 34.2059, 'longitude': 131.4914, 'address': '山口県市釣り場2'},
            {'prefecture': '山口県', 'name': '山口県釣り場3', 'description': '山口県の人気釣りスポット3', 'latitude': 34.2159, 'longitude': 131.5014, 'address': '山口県市釣り場3'},
            {'prefecture': '山口県', 'name': '山口県釣り場4', 'description': '山口県の人気釣りスポット4', 'latitude': 34.2259, 'longitude': 131.5114, 'address': '山口県市釣り場4'},
            {'prefecture': '山口県', 'name': '山口県釣り場5', 'description': '山口県の人気釣りスポット5', 'latitude': 34.2359, 'longitude': 131.5214, 'address': '山口県市釣り場5'},
            {'prefecture': '徳島県', 'name': '徳島県釣り場1', 'description': '徳島県の人気釣りスポット1', 'latitude': 34.0757, 'longitude': 134.5694, 'address': '徳島県市釣り場1'},
            {'prefecture': '徳島県', 'name': '徳島県釣り場2', 'description': '徳島県の人気釣りスポット2', 'latitude': 34.0857, 'longitude': 134.5794, 'address': '徳島県市釣り場2'},
            {'prefecture': '徳島県', 'name': '徳島県釣り場3', 'description': '徳島県の人気釣りスポット3', 'latitude': 34.0957, 'longitude': 134.5894, 'address': '徳島県市釣り場3'},
            {'prefecture': '徳島県', 'name': '徳島県釣り場4', 'description': '徳島県の人気釣りスポット4', 'latitude': 34.1057, 'longitude': 134.5994, 'address': '徳島県市釣り場4'},
            {'prefecture': '徳島県', 'name': '徳島県釣り場5', 'description': '徳島県の人気釣りスポット5', 'latitude': 34.1157, 'longitude': 134.6094, 'address': '徳島県市釣り場5'},
            {'prefecture': '香川県', 'name': '香川県釣り場1', 'description': '香川県の人気釣りスポット1', 'latitude': 34.3501, 'longitude': 134.0534, 'address': '香川県市釣り場1'},
            {'prefecture': '香川県', 'name': '香川県釣り場2', 'description': '香川県の人気釣りスポット2', 'latitude': 34.3601, 'longitude': 134.0634, 'address': '香川県市釣り場2'},
            {'prefecture': '香川県', 'name': '香川県釣り場3', 'description': '香川県の人気釣りスポット3', 'latitude': 34.3701, 'longitude': 134.0734, 'address': '香川県市釣り場3'},
            {'prefecture': '香川県', 'name': '香川県釣り場4', 'description': '香川県の人気釣りスポット4', 'latitude': 34.3801, 'longitude': 134.0834, 'address': '香川県市釣り場4'},
            {'prefecture': '香川県', 'name': '香川県釣り場5', 'description': '香川県の人気釣りスポット5', 'latitude': 34.3901, 'longitude': 134.0934, 'address': '香川県市釣り場5'},
            {'prefecture': '愛媛県', 'name': '愛媛県釣り場1', 'description': '愛媛県の人気釣りスポット1', 'latitude': 33.8516, 'longitude': 132.7756, 'address': '愛媛県市釣り場1'},
            {'prefecture': '愛媛県', 'name': '愛媛県釣り場2', 'description': '愛媛県の人気釣りスポット2', 'latitude': 33.8616, 'longitude': 132.7856, 'address': '愛媛県市釣り場2'},
            {'prefecture': '愛媛県', 'name': '愛媛県釣り場3', 'description': '愛媛県の人気釣りスポット3', 'latitude': 33.8716, 'longitude': 132.7956, 'address': '愛媛県市釣り場3'},
            {'prefecture': '愛媛県', 'name': '愛媛県釣り場4', 'description': '愛媛県の人気釣りスポット4', 'latitude': 33.8816, 'longitude': 132.8056, 'address': '愛媛県市釣り場4'},
            {'prefecture': '愛媛県', 'name': '愛媛県釣り場5', 'description': '愛媛県の人気釣りスポット5', 'latitude': 33.8916, 'longitude': 132.8156, 'address': '愛媛県市釣り場5'},
            {'prefecture': '高知県', 'name': '高知県釣り場1', 'description': '高知県の人気釣りスポット1', 'latitude': 33.5697, 'longitude': 133.5411, 'address': '高知県市釣り場1'},
            {'prefecture': '高知県', 'name': '高知県釣り場2', 'description': '高知県の人気釣りスポット2', 'latitude': 33.5797, 'longitude': 133.5511, 'address': '高知県市釣り場2'},
            {'prefecture': '高知県', 'name': '高知県釣り場3', 'description': '高知県の人気釣りスポット3', 'latitude': 33.5897, 'longitude': 133.5611, 'address': '高知県市釣り場3'},
            {'prefecture': '高知県', 'name': '高知県釣り場4', 'description': '高知県の人気釣りスポット4', 'latitude': 33.5997, 'longitude': 133.5711, 'address': '高知県市釣り場4'},
            {'prefecture': '高知県', 'name': '高知県釣り場5', 'description': '高知県の人気釣りスポット5', 'latitude': 33.6097, 'longitude': 133.5811, 'address': '高知県市釣り場5'},
            {'prefecture': '福岡県', 'name': '福岡県釣り場1', 'description': '福岡県の人気釣りスポット1', 'latitude': 33.6004, 'longitude': 130.4117, 'address': '福岡県市釣り場1'},
            {'prefecture': '福岡県', 'name': '福岡県釣り場2', 'description': '福岡県の人気釣りスポット2', 'latitude': 33.6104, 'longitude': 130.4217, 'address': '福岡県市釣り場2'},
            {'prefecture': '福岡県', 'name': '福岡県釣り場3', 'description': '福岡県の人気釣りスポット3', 'latitude': 33.6204, 'longitude': 130.4317, 'address': '福岡県市釣り場3'},
            {'prefecture': '福岡県', 'name': '福岡県釣り場4', 'description': '福岡県の人気釣りスポット4', 'latitude': 33.6304, 'longitude': 130.4417, 'address': '福岡県市釣り場4'},
            {'prefecture': '福岡県', 'name': '福岡県釣り場5', 'description': '福岡県の人気釣りスポット5', 'latitude': 33.6404, 'longitude': 130.4517, 'address': '福岡県市釣り場5'},
            {'prefecture': '佐賀県', 'name': '佐賀県釣り場1', 'description': '佐賀県の人気釣りスポット1', 'latitude': 33.2594, 'longitude': 130.3098, 'address': '佐賀県市釣り場1'},
            {'prefecture': '佐賀県', 'name': '佐賀県釣り場2', 'description': '佐賀県の人気釣りスポット2', 'latitude': 33.2694, 'longitude': 130.3198, 'address': '佐賀県市釣り場2'},
            {'prefecture': '佐賀県', 'name': '佐賀県釣り場3', 'description': '佐賀県の人気釣りスポット3', 'latitude': 33.2794, 'longitude': 130.3298, 'address': '佐賀県市釣り場3'},
            {'prefecture': '佐賀県', 'name': '佐賀県釣り場4', 'description': '佐賀県の人気釣りスポット4', 'latitude': 33.2894, 'longitude': 130.3398, 'address': '佐賀県市釣り場4'},
            {'prefecture': '佐賀県', 'name': '佐賀県釣り場5', 'description': '佐賀県の人気釣りスポット5', 'latitude': 33.2994, 'longitude': 130.3498, 'address': '佐賀県市釣り場5'},
            {'prefecture': '長崎県', 'name': '長崎県釣り場1', 'description': '長崎県の人気釣りスポット1', 'latitude': 32.7603, 'longitude': 129.8877, 'address': '長崎県市釣り場1'},
            {'prefecture': '長崎県', 'name': '長崎県釣り場2', 'description': '長崎県の人気釣りスポット2', 'latitude': 32.7703, 'longitude': 129.8977, 'address': '長崎県市釣り場2'},
            {'prefecture': '長崎県', 'name': '長崎県釣り場3', 'description': '長崎県の人気釣りスポット3', 'latitude': 32.7803, 'longitude': 129.9077, 'address': '長崎県市釣り場3'},
            {'prefecture': '長崎県', 'name': '長崎県釣り場4', 'description': '長崎県の人気釣りスポット4', 'latitude': 32.7903, 'longitude': 129.9177, 'address': '長崎県市釣り場4'},
            {'prefecture': '長崎県', 'name': '長崎県釣り場5', 'description': '長崎県の人気釣りスポット5', 'latitude': 32.8003, 'longitude': 129.9277, 'address': '長崎県市釣り場5'},
            {'prefecture': '熊本県', 'name': '熊本県釣り場1', 'description': '熊本県の人気釣りスポット1', 'latitude': 32.8131, 'longitude': 130.7179, 'address': '熊本県市釣り場1'},
            {'prefecture': '熊本県', 'name': '熊本県釣り場2', 'description': '熊本県の人気釣りスポット2', 'latitude': 32.8231, 'longitude': 130.7279, 'address': '熊本県市釣り場2'},
            {'prefecture': '熊本県', 'name': '熊本県釣り場3', 'description': '熊本県の人気釣りスポット3', 'latitude': 32.8331, 'longitude': 130.7379, 'address': '熊本県市釣り場3'},
            {'prefecture': '熊本県', 'name': '熊本県釣り場4', 'description': '熊本県の人気釣りスポット4', 'latitude': 32.8431, 'longitude': 130.7479, 'address': '熊本県市釣り場4'},
            {'prefecture': '熊本県', 'name': '熊本県釣り場5', 'description': '熊本県の人気釣りスポット5', 'latitude': 32.8531, 'longitude': 130.7579, 'address': '熊本県市釣り場5'},
            {'prefecture': '大分県', 'name': '大分県釣り場1', 'description': '大分県の人気釣りスポット1', 'latitude': 33.2482, 'longitude': 131.6226, 'address': '大分県市釣り場1'},
            {'prefecture': '大分県', 'name': '大分県釣り場2', 'description': '大分県の人気釣りスポット2', 'latitude': 33.2582, 'longitude': 131.6326, 'address': '大分県市釣り場2'},
            {'prefecture': '大分県', 'name': '大分県釣り場3', 'description': '大分県の人気釣りスポット3', 'latitude': 33.2682, 'longitude': 131.6426, 'address': '大分県市釣り場3'},
            {'prefecture': '大分県', 'name': '大分県釣り場4', 'description': '大分県の人気釣りスポット4', 'latitude': 33.2782, 'longitude': 131.6526, 'address': '大分県市釣り場4'},
            {'prefecture': '大分県', 'name': '大分県釣り場5', 'description': '大分県の人気釣りスポット5', 'latitude': 33.2882, 'longitude': 131.6626, 'address': '大分県市釣り場5'},
            {'prefecture': '宮崎県', 'name': '宮崎県釣り場1', 'description': '宮崎県の人気釣りスポット1', 'latitude': 31.9177, 'longitude': 131.4302, 'address': '宮崎県市釣り場1'},
            {'prefecture': '宮崎県', 'name': '宮崎県釣り場2', 'description': '宮崎県の人気釣りスポット2', 'latitude': 31.9277, 'longitude': 131.4402, 'address': '宮崎県市釣り場2'},
            {'prefecture': '宮崎県', 'name': '宮崎県釣り場3', 'description': '宮崎県の人気釣りスポット3', 'latitude': 31.9377, 'longitude': 131.4502, 'address': '宮崎県市釣り場3'},
            {'prefecture': '宮崎県', 'name': '宮崎県釣り場4', 'description': '宮崎県の人気釣りスポット4', 'latitude': 31.9477, 'longitude': 131.4602, 'address': '宮崎県市釣り場4'},
            {'prefecture': '宮崎県', 'name': '宮崎県釣り場5', 'description': '宮崎県の人気釣りスポット5', 'latitude': 31.9577, 'longitude': 131.4702, 'address': '宮崎県市釣り場5'},
            {'prefecture': '鹿児島県', 'name': '鹿児島県釣り場1', 'description': '鹿児島県の人気釣りスポット1', 'latitude': 31.5702, 'longitude': 130.5671, 'address': '鹿児島県市釣り場1'},
            {'prefecture': '鹿児島県', 'name': '鹿児島県釣り場2', 'description': '鹿児島県の人気釣りスポット2', 'latitude': 31.5802, 'longitude': 130.5771, 'address': '鹿児島県市釣り場2'},
            {'prefecture': '鹿児島県', 'name': '鹿児島県釣り場3', 'description': '鹿児島県の人気釣りスポット3', 'latitude': 31.5902, 'longitude': 130.5871, 'address': '鹿児島県市釣り場3'},
            {'prefecture': '鹿児島県', 'name': '鹿児島県釣り場4', 'description': '鹿児島県の人気釣りスポット4', 'latitude': 31.6002, 'longitude': 130.5971, 'address': '鹿児島県市釣り場4'},
            {'prefecture': '鹿児島県', 'name': '鹿児島県釣り場5', 'description': '鹿児島県の人気釣りスポット5', 'latitude': 31.6102, 'longitude': 130.6071, 'address': '鹿児島県市釣り場5'},
            {'prefecture': '沖縄県', 'name': '沖縄県釣り場1', 'description': '沖縄県の人気釣りスポット1', 'latitude': 26.2224, 'longitude': 127.6909, 'address': '沖縄県市釣り場1'},
            {'prefecture': '沖縄県', 'name': '沖縄県釣り場2', 'description': '沖縄県の人気釣りスポット2', 'latitude': 26.2324, 'longitude': 127.7009, 'address': '沖縄県市釣り場2'},
            {'prefecture': '沖縄県', 'name': '沖縄県釣り場3', 'description': '沖縄県の人気釣りスポット3', 'latitude': 26.2424, 'longitude': 127.7109, 'address': '沖縄県市釣り場3'},
            {'prefecture': '沖縄県', 'name': '沖縄県釣り場4', 'description': '沖縄県の人気釣りスポット4', 'latitude': 26.2524, 'longitude': 127.7209, 'address': '沖縄県市釣り場4'},
            {'prefecture': '沖縄県', 'name': '沖縄県釣り場5', 'description': '沖縄県の人気釣りスポット5', 'latitude': 26.2624, 'longitude': 127.7309, 'address': '沖縄県市釣り場5'},
          ]

          fishing_spots
        end
      end
    end
  end
end
