# libra-api
Primary API for Space Apps 2019 entry. 


Things to remember:

- the __danger_index__ range from 1-10
- this api, is isolated from the frontend
- this api should be able to process multiple datasets

### Endpoints:

#### 1. ) `/feed` (GET)
> This endpoint provides the data for the cards for the feed, data from this endpoint gathered after processing multiple datasets, from NASA, Project NOAH, etc.
__Dependencies:__
- Algorithm for calculating `danger_index`.


> Sample output:
```json
   [
       {
           "id": "item-0001",
           "country_name": "Philippines",
           "city_name": "Davao Oriental",
           "danger_index": 9.8,
           "lat": 21.85,
           "long": 108.45,
           "harzards": ["earthquake","landslide","flooding","storm_surge","typhoon","disease"
        
           ],
            "data_sources": ["nasa","noah"]
           },
           
     {...}
   ]
```
--------------------

### 2. ) `/location` (GET)
> This endpoint provides data for a __selected__ location from the feed, which gives both concise and in-depth information about the different factors of hazard from the area.
__Dependencies:__
- parameter: `locationID`  
- Algorithm for calculating `danger_index`.
> Sample output:

```json
  
      {
          "id": "item-001",
          "country-name": "Philippines",
          "city_name": "Davao Oriental",
          "danger_index": 9.0,
          "lat": 21.85,
          "long": 108.45,
          "history": [
            {
                "data_source": "NASA",
                "data_href": `dataset_link`,
                "data": {
                    "the_geom": {
                      "type": "Point",
                      "coordinates": [83.18090000000015, 19.51780000000004]
                    },
                    "objectid": "270",
                    "id": "540.0",
                    "date_": "2008-05-18T07:00:00.000Z",
                    "country": "India",
                    "nearest_pl": "Kalahandi district of Orissa, Depur village",
                    "hazard_typ": "landslide",
                    "landslide_": "Landslide",
                    "trigger": "Mining_digging",
                    "storm_name": "",
                    "fatalities": "5.0",
                    "injuries": "0.0",
                    "source_nam": "",
                    "source_lin": "http://www.thaindian.com/newsportal/uncategorized/landslide-in-orissa-claims-five-lives-lead_10050468.html",
                    "location_a": "Unknown",
                    "landslide1": "Medium",
                    "photos_lin": "",
                    "cat_src": "glc",
                    "cat_id": "540.0",
                    "countrynam": "India",
                    "near": "BhawÄ\u0081nipatna",
                    "distance": "43.1759",
                    "adminname1": "Orissa",
                    "adminname2": "",
                    "population": "64468.0",
                    "countrycod": "",
                    "continentc": "AS",
                    "key_": "IN",
                    "version": "2.0",
                    "user_id": "7.0",
                    "tstamp": "Thu Sep 11 2014 19:02:23 GMT+0000 (UTC)",
                    "changeset_": "489497023",
                    "latitude": "19.5178",
                    "longitude": "83.1809"
                  }
            }
          ]
      }
  
```
