import frame from './images/frame.png';
import map from './images/map.png';
import map2 from './images/map2.png';
import map2transparent from './images/map2transparent.png';
import hypoxic from './images/hypoxic.png';
import corn from './images/corn.png';
import fillcorn from './images/fillcorn.png';
import './new.css';
import Slider from '@mui/material/Slider';
import Box from '@mui/material/Box';
import { createTheme } from '@mui/material/styles';
//import { useState } from 'react'
// import * as React from 'react';
import React, { PureComponent } from 'react';
import { BarChart, Bar, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import Chooser from './mapChooser';
import {BASE_NITRATES, NITRATES_BY_STATE, INTIAL, WEATHER, OPTIONS} from './constants'

function Sub({mapChoices, setMap, mapSelect}) {
  
    const [data2, setData2] = React.useState(INTIAL)
    const [value1, setValue1] = React.useState(0);
    const [value2, setValue2] = React.useState(0);
    const [value3, setValue3] = React.useState(0);
    const [value4, setValue4] = React.useState(0);
    const [value5, setValue5] = React.useState(0);
    const [value6, setValue6] = React.useState(0);
    const [value7, setValue7] = React.useState(0);
    const [value8, setValue8] = React.useState(0);
    const [value9, setValue9] = React.useState(0);
    const [value10, setValue10] = React.useState(0);
    const [value11, setValue11] = React.useState(0);
    const [value12, setValue12] = React.useState(0);
    const [Indexcrop, setIndexcrop] = React.useState(3);
    const [weather, setWeather] = React.useState(0);
    const [nitrates, setNitrates] = React.useState(NITRATES_BY_STATE)
    // const [area, setArea] = React.useState(1)
   
    React.useEffect(() => {
  
      const money = { ...data2 }
      money.Fertilizer_Reduction = calcaulateFertilizerReduction(value1);
      money.Wetland_Restoration = calculateWetlandRestoration(value2);
      if (value1 == 0) {
        money.Fertilizer_Reduction = 0;
      }
      if (value2 == 0) {
        money.Wetland_Restoration = 0;
      }
     
      setData2(money);
    }, [Indexcrop])
  
  //  React.useEffect(() => {
  //    updateWaterShed(value1);
  //    updateWaterShed2(value2);
 //   }, [nitrates])
  
    React.useEffect(() => {
      const item = { ...nitrates }
        updateWaterShed(value1);
        setNitrates(item)
        updateWaterShed3(value3);
    }, [weather]);

    function updateWeather(value) {
       setWeather(value);
    }
  
    const handleChangeMissouri = (event, newValue) => {
      setValue1(newValue);
      //updateWaterShed2(value2);
      console.log(newValue)
      updateWaterShed(newValue)
    };
  
    function MissouriFactor() {
       //console.log(BASE_NITRATES.Nitrates_Entering_Watershed, weather)
      return 400 * (BASE_NITRATES.Nitrates_Entering_Watershed + weather) / 1000;
    }

    function updateWaterShed(newValue) {
      const itemMissouri = { ...nitrates }
      const moneyMissouri = { ...data2 }
  
      moneyMissouri.Fertilizer_Reduction = calcaulateFertilizerReduction(newValue)*400/1000;
      if (newValue == 0) { moneyMissouri.Fertilizer_Reduction = 0; }
      itemMissouri.Missouri = (((1-(value2/100))*(1-(newValue/100))* MissouriFactor())*0.45).toFixed(2);
      console.log('itemMissouri.Missouri', itemMissouri.Missouri);

      setNitrates(itemMissouri)
      setData2(moneyMissouri)
    }
  
    
    function calcaulateFertilizerReduction(newValue) {
      const initialprice = 68.881 * Math.pow((newValue / 100), 2) + (0.8462 * (newValue / 100)) + 0.1958;
      const cost_of_lot = (initialprice / 100) * 20;
      const Total_Cost = cost_of_lot * Indexcrop;
      return Total_Cost.toFixed(2);
    }
  
    function calcaulateNitrates(newValue) {
      const nitrate_removed = -867.13 * Math.pow((newValue / 100), 2) + (1550.8 * (newValue / 100)) + 39.93;
      return nitrate_removed.toFixed(2)
    }
  
    function calcaulateDenitrification(newValue) {
      const restore_denitrification = -375.29 * Math.pow((newValue / 100), 2) + (766.2 * (newValue / 100)) + 687.34;
  
      return restore_denitrification.toFixed(2)
    }
    const handleChangeMissouri2 = (event, newValue) => {
      setValue2(newValue);
      updateWaterShed2(newValue)
    };
  
    function updateWaterShed2(newValue) {

      const itemMissouri2 = { ...nitrates }
      const moneyMissouri2 = { ...data2 }
      moneyMissouri2.Wetland_Restoration = calculateWetlandRestoration(newValue)*400/1000;
      if (newValue == 0) { moneyMissouri2.Wetland_Restoration = 0; }
      itemMissouri2.Missouri = (((1-(newValue/100))*(1-(value1/100))* MissouriFactor())*0.45).toFixed(2);
      console.log('moneyMissouri2.Wetland_Restoration', moneyMissouri2.Wetland_Restoration);

      setNitrates(itemMissouri2)
      setData2(moneyMissouri2)
  
    };

    const handleChangeTennessee = (event, newValue) => {
      setValue3(newValue);
      updateWaterShed3(newValue)
    };
  
    function updateWaterShed3(newValue) {
      const itemTennessee = { ...nitrates }
      const moneyTennessee = { ...data2 }
  
      moneyTennessee.Fertilizer_Reduction = calcaulateFertilizerReduction(newValue)*10/1000;
      if (newValue == 0) { moneyTennessee.Fertilizer_Reduction = 0; }
      itemTennessee.Tennessee = (((1-(value4/100))*(1-(newValue/100))*TennesseeFactor())*1).toFixed(2);
      console.log('itemTennessee.Tennessee', itemTennessee.Tennessee);
      
      setNitrates(itemTennessee)
      setData2(moneyTennessee)
    }
    
    const handleChangeTennessee2 = (event, newValue) => {
      setValue4(newValue);

      const itemTennessee2 = { ...nitrates }
      const moneyTennessee2 = { ...data2 }
      moneyTennessee2.Wetland_Restoration = calculateWetlandRestoration(newValue)*10/1000;
      if (newValue == 0) { moneyTennessee2.Wetland_Restoration = 0; }

      itemTennessee2.Tennessee = (((1-(newValue/100))*(1-(value3/100))*TennesseeFactor())*1).toFixed(2);
      console.log('itemTennessee2.Tennessee', itemTennessee2.Tennessee);
      
      setNitrates(itemTennessee2)
      setData2(moneyTennessee2)
  
    };
    const handleChangeArkansas = (event, newValue) => {
      setValue5(newValue);
      updateWaterShed4(newValue)
    };
  
    function updateWaterShed4(newValue) {
      const itemArkansas = { ...nitrates }
      const moneyArkansas = { ...data2 }
      moneyArkansas.Fertilizer_Reduction = calcaulateFertilizerReduction(newValue)*120/1000;
      if (newValue == 0) { moneyArkansas.Wetland_Restoration = 0; }

      itemArkansas.Arkansas_Red_White = (((1-(value6/100))*(1-(newValue/100))*ArkansasFactor())*2).toFixed(2);
      console.log('itemArkansas.Arkansas', itemArkansas.Arkansas_Red_White);
      
      setNitrates(itemArkansas)
      setData2(moneyArkansas)
  
    };
    const handleChangeArkansas2 = (event, newValue) => {
      setValue6(newValue);

      const itemArkansas2 = { ...nitrates }
      const moneyArkansas2 = { ...data2 }
      moneyArkansas2.Wetland_Restoration = calculateWetlandRestoration(newValue)*120/1000;
      if (newValue == 0) { moneyArkansas2.Wetland_Restoration = 0; }

      itemArkansas2.Arkansas_Red_White = (((1-(newValue/100))*(1-(value5/100))*ArkansasFactor())*2).toFixed(2);
      console.log('itemArkansas2.Arkansas', itemArkansas2.Arkansas_Red_White);
      
      setNitrates(itemArkansas2)
      setData2(moneyArkansas2)
  
    };
    const handleChangeLowerMississippi = (event, newValue) => {
      setValue7(newValue);
      updateWaterShed5(newValue)
    };
  
    function updateWaterShed5(newValue) {
      const itemLowerMississippi = { ...nitrates }
      const moneyLowerMississippi = { ...data2 }
      moneyLowerMississippi.Fertilizer_Reduction = calcaulateFertilizerReduction(newValue)*50/1000;
      console.log('moneyLowerMississippi.Wetland_Restoration', moneyLowerMississippi.Wetland_Restoration);
      if (newValue == 0) { moneyLowerMississippi.Wetland_Restoration = 0; }
 
      itemLowerMississippi.Lower_Mississippi = (((1-(value8/100))*(1-(newValue/100))*LowerMississippiFactor())*3).toFixed(2);
      console.log('itemLowerMississippi.LowerMississippi', itemLowerMississippi.Lower_Mississippi);
      
      setNitrates(itemLowerMississippi)
      setData2(moneyLowerMississippi)
  
    };
    const handleChangeLowerMississippi2 = (event, newValue) => {
      setValue8(newValue);

      const itemLowerMississippi2 = { ...nitrates }
      const moneyLowerMississippi2 = { ...data2 }
      moneyLowerMississippi2.Wetland_Restoration = calculateWetlandRestoration(newValue)*50/1000;
      if (newValue == 0) { moneyLowerMississippi2.Wetland_Restoration = 0; }

      itemLowerMississippi2.Lower_Mississippi = (((1-(newValue/100))*(1-(value7/100))*LowerMississippiFactor())*3).toFixed(2);
      console.log('itemLowerMississippi2.LowerMississippi', itemLowerMississippi2.Lower_Mississippi);
      
      setNitrates(itemLowerMississippi2)
      setData2(moneyLowerMississippi2)
  
    };

    const handleChangeUpperMississippi = (event, newValue) => {
      setValue9(newValue);
      updateWaterShed6(newValue)
    };
  
    function updateWaterShed6(newValue) {
      const itemUpperMississippi = { ...nitrates }
      const moneyUpperMississippi = { ...data2 }
      moneyUpperMississippi.Fertilizer_Reduction = calcaulateFertilizerReduction(newValue)*300/1000;
      if (newValue == 0) { moneyUpperMississippi.Wetland_Restoration = 0; }
  
      itemUpperMississippi.Upper_Mississippi = (((1-(value10/100))*(1-(newValue/100))*UpperMississippiFactor())*1).toFixed(2);
      console.log('itemUpperMississippi.UpperMississippi', itemUpperMississippi.Upper_Mississippi);
      
      setNitrates(itemUpperMississippi)
      setData2(moneyUpperMississippi)
    };
      const handleChangeUpperMississippi2 = (event, newValue) => {
        setValue10(newValue);

        const itemUpperMississippi2 = { ...nitrates }
        const moneyUpperMississippi2 = { ...data2 }
        moneyUpperMississippi2.Wetland_Restoration = calculateWetlandRestoration(newValue)*300/1000;
        if (newValue == 0) { moneyUpperMississippi2.Wetland_Restoration = 0; }
    
        itemUpperMississippi2.Upper_Mississippi = (((1-(newValue/100))*(1-(value9/100))*UpperMississippiFactor())*1).toFixed(2);
        console.log('itemUpperMississippi2.UpperMississippi2', itemUpperMississippi2.Upper_Mississippi);
        
        setNitrates(itemUpperMississippi2)
        setData2(moneyUpperMississippi2)
  
    };
    const handleChangeOhio = (event, newValue) => {
      setValue11(newValue);
      updateWaterShed7(newValue)
    };
  
    function updateWaterShed7(newValue) {
      const itemOhio = { ...nitrates }
      const moneyOhio = { ...data2 }
      moneyOhio.Fertilizer_Reduction = calcaulateFertilizerReduction(newValue)*120/1000;
      if (newValue == 0) { moneyOhio.Wetland_Restoration = 0; }
  
      itemOhio.Ohio = (((1-(value12/100))*(1-(newValue/100))*OhioFactor())*1).toFixed(2);
      console.log('itemOhio.Ohio', itemOhio.Ohio);
      
      setNitrates(itemOhio)
      setData2(moneyOhio)
    };
      const handleChangeOhio2 = (event, newValue) => {
        setValue12(newValue);

        const itemOhio2 = { ...nitrates }
        const moneyOhio2 = { ...data2 }
        moneyOhio2.Wetland_Restoration = calculateWetlandRestoration(newValue)*120/1000;
        if (newValue == 0) { moneyOhio2.Wetland_Restoration = 0; }

        itemOhio2.Ohio = (((1-(newValue/100))*(1-(value11/100))*OhioFactor())*1).toFixed(2);
        console.log('itemOhio2.Ohio2', itemOhio2.Ohio);
        
        setNitrates(itemOhio2)
        setData2(moneyOhio2)
  
    };
  
    function calculateWetlandRestoration(newValue) {
      const cost_of_lot2 = (18.531 * Math.pow((newValue / 100), 2) + (1.8322 * (newValue / 100)) + 0.007) / 5;
      const Total_Cost2 = (cost_of_lot2 * Indexcrop) + ((newValue / 100) * 20);
      return Total_Cost2.toFixed(2)
    }
  
  
  
    /*var slider1 = document.getElementById("myRange1");
    var output1 = document.getElementById("slide1");
    output1.innerHTML = slider1.value;
    
    slider1.oninput = function() {
      output1.innerHTML = this.value;
    }*/
  
    /*const [top, setTop] = useState(250)
    const [left, setLeft] = useState(220)
    const [start, setStart] = useState(null)
  
    function onDragStart(e) {
        setStart({ x: e.clientX - left, y: e.clientY - top})
        e.preventDefault();
    }
  
    function onDrag(e) {
       
        if (start !== null) {
            const dx = start.x - e.clientX;
            //const dy = start.y - e.clientY;
           // setTop(-dy)
            setLeft(-dx)
        }
        e.preventDefault();
    }
  
    function onDragEnd() {
        console.log('END')
        setStart(null)
    }*/
    

    const total_area=calculate_area();
    function calculate_area(){
      const totalnit=Number(nitrates.Lower_Mississippi)+Number(nitrates.Arkansas_Red_White)+Number(nitrates.Ohio)+Number(nitrates.Tennessee)+Number(nitrates.Upper_Mississippi)+Number(nitrates.Missouri);
      let total_area=((totalnit-687.34)*20)-5000;
      if (total_area<0){total_area=0;}
      return total_area;
    }
    
    const total_percent_reduction=calculate_reduction_crop_yield();
    function calculate_reduction_crop_yield(){
      const percent_reduction1= 68.881 * Math.pow((value1 / 100), 2) + (0.8462 * (value1 / 100)) + 0.1958;
      const percent_reduction2= 18.531 * Math.pow((value2 / 100), 2) + (1.8322 * (value2 / 100)) + 0.007;
      const total_percent_reduction= 100-((100-percent_reduction1)*(1-percent_reduction2/100));
      return total_percent_reduction;
    }
    //console.log('total_percent_reduction', total_percent_reduction)
    const overlay = { 
        position: 'absolute',
        zIndex: 7, left: 20, top: 320,
        clip : `rect(${361 - (361*total_percent_reduction/100)}px, 320px, 900px, 0px)` 
    }
    
     console.log('total_area', total_area)

    function UpperMississippiFactor() {
      //console.log(BASE_NITRATES.Nitrates_Entering_Watershed, weather)
     return 300 * (BASE_NITRATES.Nitrates_Entering_Watershed + weather) / 1000;
   }

   function TennesseeFactor() {
    //console.log(BASE_NITRATES.Nitrates_Entering_Watershed, weather)
   return 10 * (BASE_NITRATES.Nitrates_Entering_Watershed + weather) / 1000;
 }
 function OhioFactor() {
  //console.log(BASE_NITRATES.Nitrates_Entering_Watershed, weather)
 return 120 * (BASE_NITRATES.Nitrates_Entering_Watershed + weather) / 1000;
}
function ArkansasFactor() {
  //console.log(BASE_NITRATES.Nitrates_Entering_Watershed, weather)
 return 120 * (BASE_NITRATES.Nitrates_Entering_Watershed + weather) / 1000;
}
function LowerMississippiFactor() {
  //console.log(BASE_NITRATES.Nitrates_Entering_Watershed, weather)
 return 50 * (BASE_NITRATES.Nitrates_Entering_Watershed + weather) / 1000;
}

  
    return (
      <div className="App">
  
        <img src={frame} alt="main frame" height={720} width={950} />
        {/* <img src={map} alt="main map" height={700} width={700} style={{ position: 'absolute', zIndex: 2, left: 0, top: 20 }} /> */}
        <img src={map2} alt="map2" height={700} width={700} style={{ position: 'absolute', zIndex: 2, left: 10, top: 20 }} />
        <img src={map2transparent} alt="map2transparent" height={700} width={700} style={{opacity: 0.5, position: 'absolute', zIndex: 3, left: 10, top: 20 }} />
        <img src={hypoxic} alt="hypoxic"  width={300 * ((total_area)/24853.2)} style={{ position: 'absolute', zIndex: 6, left: 324, top: 570 }} />
      <div style={{ position: 'absolute', zIndex: 6, left: 323, top: 644 }}>
        <h4>
        |&emsp;&ensp;|&emsp;&ensp;|&emsp;&ensp;|&emsp;&ensp;|&emsp;&ensp;|&emsp;&ensp;|&emsp;&ensp;|&emsp;&ensp;|&emsp;&ensp;|&emsp; &ensp;|
        </h4>
        </div>
        <div style={{ position: 'absolute', zIndex: 6, left: 313, top: 664 }}>
          <h5>
        0 km<sup>2</sup>&emsp; 5,000 &emsp; 10,000&emsp; 15,000 &emsp;20,000 &emsp; 25,000
        </h5>
        </div>
        <div className="percentage" style={{ position: 'absolute', zIndex: 8, left: -100, top: 466 }}>
        <p>|&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |&ensp; &nbsp; |
        </p>
      </div>
      <div className="percentage2" style={{ position: 'absolute', zIndex: 8, left: 40, top: 285 }}>
        <p>100<br></br>90<br></br>80<br></br>70<br></br>60<br></br>50<br></br>40<br></br>30<br></br>20<br></br>10<br></br>0</p>
      </div>
      
        <img src={corn} alt="corn" height={362} width={153} style={{ position: 'absolute', zIndex: 6, left: 20, top: 320 }} />
        <img src={fillcorn} alt="fillcorn" height={362} width={153} style={overlay} />
        <div className='text-on-image' style={{ zIndex: 4 }}>
          <h1> THE NITROGEN GAME</h1>
        </div>
        <div className='text-on-image2' style={{ zIndex: 5 }}>
          <p>The Mississippi<br></br> Watershed</p>
        </div>
        <div className='text-on-image3' style={{ zIndex: 5 }}>
          <p>Missouri</p>
        </div>
        <div className='text-on-image4' style={{ zIndex: 5 }}>
          <p>Upper <br></br> Mississippi</p>
        </div>
        <div className='text-on-image5' style={{ zIndex: 5 }}>
          <p>Ohio</p>
        </div>
        <div className='text-on-image6' style={{ zIndex: 5 }}>
          <p>Tennessee</p>
        </div>
        <div className='text-on-image7' style={{ zIndex: 5 }}>
          <p>Arkansas <br></br> Red-White</p>
        </div>
        <div className='text-on-image8' style={{ zIndex: 5 }}>
          <p>Lower <br></br> Mississippi</p>
        </div>

        <div className='dropdown-text' style={{ zIndex: 10 }}>
          <p><b>WATERSHED</b></p>
        </div>
        <div className='dropdown' style={{ zIndex: 10 }}>
          {/* <select className='dropdown2'>
            <option value="WHOLE">WHOLE</option>
            <option value="SUB_WATERSHEDS">SUB WATERSHEDS</option>
            <option value="PAST_HYPOXIC_ZONES">PAST HYPOXIC ZONES</option>
          </select> */}
         <Chooser mapChoices={mapChoices} mapSelect={mapSelect} setMap={setMap} />
        </div>
        <div className='weather-text' style={{ zIndex: 10 }}>
          <p><b>WEATHER</b></p>
        </div>
        <div className='weather' style={{ zIndex: 10 }}>
          {/* <select className= 'weather2'>
                  <option value="WET_YEAR">WET YEAR</option>
                  <option value="MEDIUM">MEDIUM</option>
                  <option value="DRY_YEAR">DRY YEAR</option>
              </select> */}
          <FormControl sx={{ m: 0.1, minWidth: 80 }}>
            <Select
              labelId="weather"
              id="weather"
              value={weather}
              displayEmpty
              inputProps={{ 'aria-label': 'Without label' }}
              onChange={(e) => updateWeather(e.target.value)}
            >
              {WEATHER.map((item) => {
                return (
                  <MenuItem value={item.value} key={item.value}>
                    {item.label}
                  </MenuItem>
                );
              })}
            </Select>
          </FormControl>
        </div>
        <div className='crop-text' style={{ zIndex: 10 }}>
          <p><b>CROP PRICE INDEX</b></p>
        </div>
        <div className='crop' style={{ zIndex: 10 }}>
  
          {/* <select className= 'crop2'> */}
          {/* <option value="VERY_LOW">VERY LOW</option>
                  <option value="LOW">LOW</option>
                  <option value="MEDIUM">MEDIUM</option>
                  <option value="HIGH">HIGH</option>
                  <option value="VERY_HIGH">VERY HIGH</option> */}
  
          <FormControl sx={{ m: 0.1, minWidth: 80 }}>
            <Select
              labelId="Indexcrop"
              id="Indexcrop"
              value={Indexcrop}
              displayEmpty
              inputProps={{ 'aria-label': 'Without label' }}
  
              onChange={(e) => setIndexcrop(e.target.value)}
            >
              {OPTIONS.map((item) => {
                return (
                  <MenuItem value={item.value} key={item.value}>
                    {item.label}
                  </MenuItem>
                );
              })}
            </Select>
          </FormControl>
  
          {/* </select> */}
  
        </div>
        <div className='filter-range'>
          {/* <div className='filter-range-title'>Fertilization Reduction (%)</div> */}
          {/* <div className='slidercontainer'>
                    <input type="range" min="0" max="100" defaultValue="0" className="slider" step="1" id="myRange1" />
                    <div> <span id="slide1">0</span> </div>
                    <input type="range" min="0" max="100" defaultValue="0" className="slider2" step="1" id="myRange2" />
                    <div> <span id="slide2">0</span> </div>
                  </div> */}
          {/* <div className="filter-range-title2">Wetland Restoration (% area)</div> */}
        </div>
        <div className='bar-y'style={{ zIndex: 18 }}>
              <h5>(thousand <br></br> tonnes)</h5>
          </div>
        <div className='bar3'>
          <BarChart style={{ zIndex: 18 }}
            width={200}
            height={500}
            data={[nitrates]}
            margin={{
              top: 0,
              right: 30,
              left: 20,
              bottom: 5
            }}
          >
            <XAxis dataKey="nitratebar" />
            <YAxis type="number" domain={[0, 2200]} />
            <Tooltip />
            {/* <Legend /> */}
            {/* Tennessee */}
            <Bar dataKey="Tennessee" stackId="a" name="Tennessee" fill="rgb(185,94,61)" />
           {/* Lower Mississippi */}
           <Bar dataKey="Lower_Mississippi" stackId="a" name="Lower Mississippi" fill="rgb(121,123,69)" />
            {/* Arkansas Red-White */}
            <Bar dataKey="Arkansas_Red_White" stackId="a" name="Arkansas Red-White" fill="rgb(185,80,113)" />
            {/* Ohio */}
            <Bar dataKey="Ohio" stackId="a" name="Ohio" fill="rgb(194,201,43)" />
            {/* Upper Mississippi */}
            <Bar dataKey="Upper_Mississippi" stackId="a" name="Upper Mississippi" fill="rgb(140,99,114)" />
             {/* Missouri */}
             <Bar dataKey="Missouri" stackId="a" name="Missouri" fill="rgb(150,189,150)" />
          </BarChart>
        </div>
        <div className='bar-x'style={{ zIndex: 18 }}>
              <h5>($ billion)</h5>
          </div>
        <div className='bar4'>
          <BarChart style={{ zIndex: 17 }}
            width={150}
            height={500}
            data={[data2]}
            margin={{
              top: 0,
              right: 30,
              left: 20,
              bottom: 5
            }}
          >
  
            <XAxis dataKey="moneybar" />
            <YAxis type="number" domain={[0, 10]} allowDataOverflow={true} />
            <Tooltip />
            {/* <Legend /> */}
            
            <Bar dataKey="Fertilizer_Reduction" stackId="a" name="Fertilizer Reduction"
               fill={ Number(data2.Fertilizer_Reduction) + Number(data2.Wetland_Restoration) >10 ? "red" : "green"} />
            <Bar dataKey="Wetland_Restoration" stackId="a" name="Wetland Restoration"
               fill={ Number(data2.Fertilizer_Reduction) + Number(data2.Wetland_Restoration) >10 ? "red" : "green"}
            />
            
          </BarChart>
        </div>
  
        <div className='sliderMissouri'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "secondary.light",
                marginTop: "-13px",
              },
              "& .MuiSlider-track": {
                height: 0
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeMissouri}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
  
        <div className='sliderMissouri2'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "primary.light",
                marginTop: "13px",
  
              },
              "& .MuiSlider-track": {
                height: 0
  
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeMissouri2}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderUpperMississippi'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "secondary.light",
                marginTop: "-13px",
              },
              "& .MuiSlider-track": {
                height: 0
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeUpperMississippi}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderUpperMississippi2'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "primary.light",
                marginTop: "13px",
  
              },
              "& .MuiSlider-track": {
                height: 0
  
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeUpperMississippi2}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderOhio'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "secondary.light",
                marginTop: "-13px",
              },
              "& .MuiSlider-track": {
                height: 0
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeOhio}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderOhio2'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "primary.light",
                marginTop: "13px",
  
              },
              "& .MuiSlider-track": {
                height: 0
  
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeOhio2}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderTennessee'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "secondary.light",
                marginTop: "-13px",
              },
              "& .MuiSlider-track": {
                height: 0
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeTennessee}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderTennessee2'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "primary.light",
                marginTop: "13px",
  
              },
              "& .MuiSlider-track": {
                height: 0
  
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeTennessee2}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderArkansas'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "secondary.light",
                marginTop: "-13px",
              },
              "& .MuiSlider-track": {
                height: 0
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeArkansas}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderArkansas2'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "primary.light",
                marginTop: "13px",
  
              },
              "& .MuiSlider-track": {
                height: 0
  
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeArkansas2}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderLowerMississippi'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "secondary.light",
                marginTop: "-13px",
              },
              "& .MuiSlider-track": {
                height: 0
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeLowerMississippi}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        <div className='sliderLowerMississippi2'>
          <Box sx={{ width: 180 }} >
            <Slider style={{ zIndex: 21 }} sx={{
              color: '#000',
              '& .MuiSlider-thumb': {
                backgroundColor: "primary.light",
                marginTop: "13px",
  
              },
              "& .MuiSlider-track": {
                height: 0
  
              },
            }}
              aria-label="Always visible"
              defaultValue={0}
              onChange={handleChangeLowerMississippi2}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>
        
        <div className='corntext' style={{ zIndex: 21 }}>
          <h3>Crop Yield Reduction(%)</h3>
        </div>
      </div>
    );
  }
  
  export default Sub;