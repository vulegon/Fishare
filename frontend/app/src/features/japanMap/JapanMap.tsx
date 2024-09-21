import React, { useEffect } from 'react';
import * as d3 from 'd3';
import geoJson from './mapData/japan.geo.json';

//
// 以下のページで詳細を解説しています
// https://qiita.com/alclimb/items/31d4360c74a8f8935256
//
export const JapanMap: React.FC = () => {
// GeoJsonファイルを読み込み

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
        .text(label);

      // テキストのサイズから矩形のサイズを調整
      const padding = { x: 5, y: 0 };
      const textSize = textElement.node()?.getBBox();
      if (!textSize) return;
      rectElement
        .attr(`x`, textSize.x - padding.x)
        .attr(`y`, textSize.y - padding.y)
        .attr(`width`, textSize.width + padding.x * 2)
        .attr(`height`, textSize.height + padding.y * 2);

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

      // ラベルの位置を移動
      // svg
      //   .select('#label-group')
      //   .attr(`transform`, `translate(${labelPos.x}, ${labelPos.y})`);
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

useEffect(() => {
  drawJapanMap();
}, []);
  return (
    <>
      <div>
        <div id="map-container"></div>
      </div>
    </>
  );
};
