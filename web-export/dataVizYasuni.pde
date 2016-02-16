JSONObject json;

void setup(){
  
  size(400, 400);
  json = loadJSONObject("data.json");
  JSONArray bubbleData = json.getJSONArray("ubicaciones");
    println(bubbleData);

}

void draw(){
  
}

