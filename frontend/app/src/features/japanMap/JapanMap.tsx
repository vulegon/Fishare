import React, { useEffect, useState } from 'react';
import * as d3 from 'd3';
import geoJson from './mapData/japan.geo.json';
import { useNavigate } from 'react-router-dom';
import apiClient from 'api/v1/apiClient';
import { Prefecture } from 'types';

type GeoJsonFeature = {
  properties: {
    name_ja: string;
  };
};

export const JapanMap: React.FC = () => {
  const navigate = useNavigate();
  const [prefectures, setPrefectures] = useState<Prefecture[]>([]);
  const [isPrefectureLoad, setIsPrefectureLoad] = useState(false);

  const drawJapanMap = async () => {
    const width = 500; // 描画サイズ: 幅
    const height = 500; // 描画サイズ: 高さ
    const centerPos: [number, number] = [137.0, 38.2]; // 地図のセンター位置
    const scale = 1000; // 地図のスケール

    d3.select('#map-container').selectAll('svg').remove();

    // 地図の投影設定
    const projection = d3
      .geoMercator()
      .center(centerPos)
      .translate([width / 2, height / 2])
      .scale(scale);

    // 地図をpathに投影(変換)
    const path = d3.geoPath().projection(projection);

    // SVG要素を追加
    const svg = d3
      .select(`#map-container`)
      .append(`svg`)
      .attr(`viewBox`, `0 0 ${width} ${height}`)
      .attr(`width`, `100%`)
      .attr(`height`, `100%`);

    //
    // [ メモ ]
    // 動的にGeoJsonファイルを読み込む場合は以下のコードを使用
    // const geoJson = await d3.json(`/japan.geo.json`);
    //

    // 都道府県の領域データをpathで描画
    svg
      .selectAll(`path`)
      .data(geoJson.features)
      .enter()
      .append(`path`)
      .attr(`d`, path as any)
      .attr(`stroke`, `#666`)
      .attr(`stroke-width`, 0.25)
      .attr(`fill`, `#98E4C1`)

      /**
       * 都道府県領域の MouseOver イベントハンドラ
       */
      .on(`mouseover`, function (item: any) {
        const centroid = path.centroid(item); // 都道府県の重心座標を取得
        // ラベル用のグループ
        const group = svg.append(`g`).attr(`id`, `label-group`);

        // 地図データから都道府県名を取得する
        const label = item.properties.name_ja;

        // 矩形を追加: テキストの枠
        const rectElement = group
          .append(`rect`)
          .attr(`id`, `label-rect`)
          .attr(`stroke`, `#666`)
          .attr(`stroke-width`, 0.5)
          .attr(`fill`, `#fff`);

        // テキストを追加
        const textElement = group
          .append(`text`)
          .attr(`id`, `label-text`)
          .attr("x", 10)  // x座標
          .attr("y", 20) // y座標
          .text(label)
          .attr("font-size", "10px");

        // テキストのサイズから矩形のサイズを調整
        const padding = { x: 5, y: 0 };
        const textSize = textElement.node()?.getBBox();
        if (!textSize) return;
        rectElement
          .attr(`x`, textSize.x - padding.x)
          .attr(`y`, textSize.y - padding.y)
          .attr(`width`, textSize.width + padding.x * 2)
          .attr(`height`, textSize.height + padding.y * 2);

          group.attr(`transform`, `translate(${centroid[0]}, ${centroid[1]})`);
        // マウス位置の都道府県領域を赤色に変更
        d3.select(this).attr(`fill`, `#CC4C39`);
        d3.select(this).attr(`stroke-width`, `1`);
      })

      /**
       * 都道府県領域の MouseMove イベントハンドラ
       */
      .on('mousemove', function (event: MouseEvent, item: any) {
        // テキストのサイズ情報を取得
        const textElement = svg.select('#label-text').node() as SVGGraphicsElement | null;

        if (!textElement) return;
        // マウス位置からラベルの位置を指定
        const textSize = textElement.getBBox();
        const labelPos = {
          x: event.offsetX - textSize.width,
          y: event.offsetY - textSize.height,
        };

      })

      /**
      * 都道府県領域の Click イベントハンドラ
      */
      .on(`click`, function (event: any, item: any) {
        const prefectureName = d3.select<SVGPathElement, GeoJsonFeature>(this).datum().properties.name_ja;
        console.log(prefectures);
        const target_prefecture = prefectures.find((prefecture) => prefecture.name === prefectureName);
        if (!target_prefecture) return;
        navigate(`/prefectures/${target_prefecture.id}/spots`);
      })

      /**
       * 都道府県領域の MouseOut イベントハンドラ
       */
      .on(`mouseout`, function (item: any) {
        // ラベルグループを削除
        svg.select('#label-group').remove();

        // マウス位置の都道府県領域を青色に戻す
        d3.select(this).attr(`fill`, `#98E4C1`);
        d3.select(this).attr(`stroke-width`, `0.25`);
      });


  };

  const fetchPrefectures = async () => {
    try {
      const res = await apiClient.getPrefectures();
      setPrefectures(res.prefectures);
      setIsPrefectureLoad(true);
    } catch (err) {
      console.error(err);
    }
  };

  useEffect(() => {
    fetchPrefectures();
    drawJapanMap();
  }, [isPrefectureLoad]);

  return (
    <div>
      <div id="map-container"></div>
    </div>
  );
};
