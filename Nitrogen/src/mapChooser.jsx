import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

function Chooser({mapChoices, setMap, mapSelect}) {
    return (
      <FormControl fullWidth>
  
        <Select
          labelId="map"
          id="map"
          value={mapSelect}
          displayEmpty
          inputProps={{ 'aria-label': 'Without label' }}
          onChange={(e) => setMap(e.target.value)}
        >
          {mapChoices.map((item) => {
            return (
              <MenuItem value={item.value} key={item.value}>
                {item.label}
              </MenuItem>
            );
          })}
        </Select>
      </FormControl>
    )
}

export default Chooser;

  