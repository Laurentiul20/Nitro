import frame from './images/frame.png';
import map from './images/map.png';
import map2 from './images/map2.png';
import map2transparent from './images/map2transparent.png';
import hypoxic from './images/hypoxic.png';
import corn from './images/corn.png';
import fillcorn from './images/fillcorn.png';
import './App.css';
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

import Sub from './Sub.js';
import Chooser from './mapChooser';
import {BASE_NITRATES, INTIAL, WEATHER, OPTIONS} from './constants'

function App() {
  const mapChoices = [
    {
      label: "WHOLE", value: 0
    },
    {
      label: "SUB WATERSHEDS", value:1
    },
    {
      label: "PAST HYPOXIC ZONES", value:2
    }
  ];
  const [mapSelect, setMap] = React.useState(0)

  if(mapSelect == 0) {
    return <Whole mapChoices={mapChoices} mapSelect={mapSelect} setMap={setMap} />
  }
  else {
    return <Sub mapChoices={mapChoices} mapSelect={mapSelect} setMap={setMap} />
  }
  
}

function Whole({mapChoices, setMap, mapSelect}) {
 
  const [data, setData] = React.useState(BASE_NITRATES)
  const [data2, setData2] = React.useState(INTIAL)
  const [value1, setValue1] = React.useState(0);
  const [value2, setValue2] = React.useState(0);
  const [Indexcrop, setIndexcrop] = React.useState(3);
  const [Weather, setWeather] = React.useState(0);
  const [nitrates, setNitrates] = React.useState(BASE_NITRATES)
  //const [currentMap, setCurrentMap] = React.useState(map)
  
 
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

  React.useEffect(() => {
    updateWaterShed(value1)
  }, [nitrates])

  
  React.useEffect(() => {
    const item = { ...nitrates }
    item.Nitrates_Entering_Watershed = BASE_NITRATES.Nitrates_Entering_Watershed + Weather;
    setNitrates(item);
  }, [Weather]);

  const handleChange = (event, newValue) => {
    setValue1(newValue);
    
    console.log(newValue)
    updateWaterShed(newValue)
  };

  // function changeMap(e) {
  //     setMap(e.target.value)
  //     if(e.target.value == 1) {
  //       setCurrentMap(map2)
  //     }
  //     if(e.target.value == 0) {
  //       setCurrentMap(map)
        
  //     }
  //     setData(BASE_NITRATES)
  //     setData2(initial2);
  //     setNitrates(BASE_NITRATES)
  // }
  function updateWaterShed(newValue) {
    const item = { ...data }
    const money = { ...data2 }

    money.Fertilizer_Reduction = calcaulateFertilizerReduction(newValue)
    if (newValue == 0) { money.Fertilizer_Reduction = 0; }
    // calculates data for Nitrates_Entering_Watershed

    item.Nitrates_Entering_Watershed = (nitrates.Nitrates_Entering_Watershed - calcaulateNitrates(newValue)).toFixed(2);

    if (newValue == 0) { item.Nitrates_Entering_Watershed = nitrates.Nitrates_Entering_Watershed; }


    item.Nitrates_to_Gulf = (item.Nitrates_Entering_Watershed - item.Denitrification).toFixed(2);
    if (item.Nitrates_to_Gulf<0){item.Nitrates_to_Gulf=0;}
    
    setData(item)
    setData2(money)
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
  const handleChange2 = (event, newValue) => {
    setValue2(newValue);
    //setArea( (100 - newValue) / 100)
    
    console.log('Nitrates_to_Gulft', data.Nitrates_to_Gulf)

    // calculates Wetland Restoration cost
    const item2 = { ...data }
    const money2 = { ...data2 }
    money2.Wetland_Restoration = calculateWetlandRestoration(newValue);
    if (newValue == 0) { money2.Wetland_Restoration = 0; }

    //calculates data for Denitrification
    // const restore_denitrification= -375.29*Math.pow((newValue/100), 2)+(766.2*(newValue/100))+687.34;
    // console.log('restore_denitrification', restore_denitrification);
    item2.Denitrification = calcaulateDenitrification(newValue);
    console.log('Denitrification', item2.Denitrification)
    item2.Nitrates_to_Gulf = (item2.Nitrates_Entering_Watershed - item2.Denitrification).toFixed(2);
    if (item2.Nitrates_to_Gulf<0){item2.Nitrates_to_Gulf=0;}


    
    setData(item2)
    setData2(money2)

  };

  function calculateWetlandRestoration(newValue) {
    const cost_of_lot2 = (18.531 * Math.pow((newValue / 100), 2) + (1.8322 * (newValue / 100)) + 0.007) / 5;
    const Total_Cost2 = (cost_of_lot2 * Indexcrop) + ((newValue / 100) * 20);
    return Total_Cost2.toFixed(2)
  }



  // setData((prevData) => {
  //   const newData = [...prevData];
  //   const item = newData[0]
  //   const calculation = Math.abs(newValue-tempValue)*100;
  //   console.log('calculation', calculation);
  //   if (newValue > tempValue) {
  //     //item.Nitrates_Entering_Watershed = item.Nitrates_Entering_Watershed + 100;
  //     item.Nitrates_Entering_Watershed = item.Nitrates_Entering_Watershed + calculation;
  //   } else if (newValue == tempValue){
  //     item.Nitrates_Entering_Watershed = item.Nitrates_Entering_Watershed;
  //   }
  //   else {
  //     item.Nitrates_Entering_Watershed = item.Nitrates_Entering_Watershed - calculation;
  //   }
  //   setTempValue(newValue);
  //  return newData;
  // });

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
    let total_area=(data.Nitrates_to_Gulf-(value2 / 100)*data.Nitrates_to_Gulf)*20-5000
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
  console.log('total_percent_reduction', total_percent_reduction)
  const overlay = { 
      position: 'absolute',
      zIndex: 7, left: 20, top: 320,
      clip : `rect(${361 - (361*total_percent_reduction/100)}px, 320px, 900px, 0px)` 
  }

  // console.log('total_area', total_area)

  return (
    <div className="App">

      <img src={frame} alt="main frame" height={720} width={950} />
      <img src={map} alt="main map" height={700} width={700} style={{ position: 'absolute', zIndex: 2, left: 0, top: 20 }} />
     
      {/* <img src={map2transparent} alt="map2transparent" height={700} width={700} style={{opacity: 0.2, position: 'absolute', zIndex: 1, left: 0, top: 20 }} /> */}
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
            value={Weather}
            displayEmpty
            inputProps={{ 'aria-label': 'Without label' }}
            

            onChange={(e) => setWeather(e.target.value)}
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
        <div className='filter-range-title'>Fertilization Reduction (%)</div>
        {/* <div className='slidercontainer'>
                  <input type="range" min="0" max="100" defaultValue="0" className="slider" step="1" id="myRange1" />
                  <div> <span id="slide1">0</span> </div>
                  <input type="range" min="0" max="100" defaultValue="0" className="slider2" step="1" id="myRange2" />
                  <div> <span id="slide2">0</span> </div>
                </div> */}
        <div className="filter-range-title2">Wetland Restoration (% area)</div>
      </div>
      <div className='bar-y'style={{ zIndex: 18 }}>
            <h5>(thousand <br></br> tonnes)</h5>
        </div>
      <div className='bar'>
        <BarChart style={{ zIndex: 18 }}
          width={200}
          height={500}
          data={[data]}
          margin={{
            top: 0,
            right: 30,
            left: 20,
            bottom: 5
          }}
        >
          <XAxis dataKey="nitratebar" />
          <YAxis type="number" domain={[0, 5000]} />
          <Tooltip />
          {/* <Legend /> */}
          <Bar dataKey="Nitrates_Entering_Watershed" stackId="a" name="Nitrates Entering Watershed" fill="#8884d8" />
          <Bar dataKey="Denitrification" stackId="a" name="Denitrification" fill="#82ca9d" />
          <Bar dataKey="Nitrates_to_Gulf" stackId="a" name="Nitrates to Gulf" fill="purple" />
        </BarChart>
      </div>
      <div className='bar-x'style={{ zIndex: 18 }}>
            <h5>($ billion)</h5>
        </div>
      <div className='bar2'>
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
      {<>
            <Slider1 handleChange={handleChange} />
            <Slider2 handleChange={handleChange2} />  
          </>
      }
      
      
      <div className='corntext' style={{ zIndex: 21 }}>
        <h3>Crop Yield Reduction(%)</h3>
      </div>
    </div>
  );
}

function Slider2({handleChange}) {
  return(<div className='slider2'>
          <Box sx={{ width: 300 }} >
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
              onChange={handleChange}
              min={0}
              max={100}
              marks
              step={1}
              valueLabelDisplay="auto" />
          </Box>
        </div>)
}

function Slider1({handleChange}) {
  return (<div className='slider1'>
              <Box sx={{ width: 300 }} >
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
                  onChange={handleChange}
                  min={0}
                  max={100}
                  marks
                  step={1}
                  valueLabelDisplay="auto" />
              </Box>
        </div>
  )
} 

export default App;
