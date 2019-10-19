# libra-api

Primary API for Space Apps 2019 entry.

Things to remember:

- the **danger_index** range from 1-10
- this api, is isolated from the frontend
- this api should be able to process multiple datasets

### Endpoints:

#### 1. ) `/feed` (GET)

> This endpoint provides the data for the cards for the feed, data from this endpoint gathered after processing multiple datasets, from NASA, Project NOAH, etc.
> **Dependencies:**

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

---

### 2. ) `/location` (GET)

> This endpoint provides data for a **selected** location from the feed, which gives both concise and in-depth information about the different factors of hazard from the area.
> **Dependencies:**

- parameter: `locationID`
- Algorithm for calculating `danger_index`.
  > Sample output:

```json
[
  {
    "id": "item-944",
    "country_name": "Philippines",
    "city_name": "Davao",
    "danger_index": 0,
    "data_source": "nasa",
    "lat": "7.3521",
    "long": "126.1544",
    "history": {
      "the_geom": {
        "type": "Point",
        "coordinates": [126.15440000000012, 7.35210000000007]
      },
      "objectid": "942",
      "id": "3530.0",
      "date_": "2011-05-23T07:00:00.000Z",
      "country": "Philippines",
      "nearest_pl": "Maragusan, COMVAL",
      "hazard_typ": "landslide",
      "landslide_": "Landslide",
      "trigger": "Tropical_Cyclone",
      "storm_name": "Typhoon Chedeng (Songda)",
      "fatalities": "0.0",
      "injuries": "0.0",
      "source_nam": "",
      "source_lin": "http://reliefweb.int/sites/reliefweb.int/files/resources/NDRRMC Update Sitrep No. 15 CHEDENG31May2011, 6PM.pdf",
      "location_a": "Known_within_25_km",
      "landslide1": "Medium",
      "photos_lin": "",
      "cat_src": "glc",
      "cat_id": "3530.0",
      "countrynam": "Philippines",
      "near": "San Mariano",
      "distance": "23.62322",
      "adminname1": "Davao",
      "adminname2": "Davao",
      "population": "18668.0",
      "countrycod": "",
      "continentc": "AS",
      "key_": "PH",
      "version": "1.0",
      "user_id": "1.0",
      "tstamp": "Tue Apr 01 2014 00:00:00 GMT+0000 (UTC)",
      "changeset_": "1.0",
      "latitude": "7.3521",
      "longitude": "126.1544"
    }
  }
]
```
