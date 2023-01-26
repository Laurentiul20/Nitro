import frame from './images/frame.png';
import map from './images/map.png';
import red from './images/red.png'
import './App.css';
import { useState } from 'react'

function App() {
    const [top, setTop] = useState(200)
    const [left, setLeft] = useState(250)
    const [start, setStart] = useState(null)

    function onDragStart(e) {
        setStart({ x: e.clientX - left, y: e.clientY - top})
        e.preventDefault();
    }

    function onDrag(e) {
       
        if (start !== null) {
            const dx = start.x - e.clientX;
            const dy = start.y - e.clientY;
           // setTop(-dy)
            setLeft(-dx)
        }
        e.preventDefault();
    }
    // open streat maps, leaflet  for maps maybe
    // google charts or any other charts library for the vertical slider like thing
    // possibly the vertical slider maybe available in reat material ui
    // even the slider might be in the material ui library (react available)
    // the drop downs aagain maybe usable directly from react material or
    // they can be built using option/select and states

    function onDragEnd() {
        console.log('END')
        setStart(null)
    }

    return (
        <div className="App">
            <img src={frame} alt="main frame" height={700} width={800} />
            <img src={map} alt="main map" height={700} width={700} style={{ position: 'absolute', zIndex:2, left: 0, top: 0 }} />
            <img src={red} style={{ position: 'absolute', top: top, left: left, zIndex: 3 }}
                onMouseDown={onDragStart} onMouseMove={onDrag} onMouseUp={onDragEnd}
            />
        </div>
  );
}

export default App;
