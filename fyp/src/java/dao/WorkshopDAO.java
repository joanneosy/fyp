/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import entity.CarBrand;
import entity.Workshop;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.w3c.dom.Document;
import util.ConnectionManager;

/**
 *
 * @author Fixxlar
 */
public class WorkshopDAO {

    private final String USER_AGENT = "Mozilla/5.0";

    public Workshop retrieveWorkshop(String givenEmail, int staffId, String token) throws UnsupportedEncodingException, IOException {
        Workshop ws = null;
        String url = "http://119.81.43.85/erp/workshop/get_shop_by_id_or_email";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("email", givenEmail));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();

        JsonElement shopElement = jobj.get("payload");
        JsonObject shop = null;
        if (shopElement.isJsonNull()) {
            return ws;
        } else {
            shop = shopElement.getAsJsonObject().getAsJsonObject("shop");
            JsonElement attElement = shop.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = shop.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = shop.get("website");
            String website = "";
            if (!attElement.isJsonNull()) {
                website = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_full");
            String openingHour = "";
            if (!attElement.isJsonNull()) {
                openingHour = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_format");
            String openingHourFormat = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat = attElement.getAsString();
            }
            attElement = shop.get("latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }
            attElement = shop.get("longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }
            attElement = shop.get("contact");
            String contact = "";
            if (!attElement.isJsonNull()) {
                contact = attElement.getAsString();
            }
            attElement = shop.get("contact2");
            String contact2 = "";
            if (!attElement.isJsonNull()) {
                contact2 = attElement.getAsString();
            }
            attElement = shop.get("location");
            String location = "";
            if (!attElement.isJsonNull()) {
                location = attElement.getAsString();
            }
            attElement = shop.get("specialize");
            String specialize = "";
            if (!attElement.isJsonNull()) {
                specialize = attElement.getAsString();
            }
            attElement = shop.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }
            attElement = shop.get("brand_carried");
            String brandsCarried = "";
            if (!attElement.isJsonNull()) {
                brandsCarried = attElement.getAsString();
            }
            attElement = shop.get("remark");
            String remark = "";
            if (!attElement.isJsonNull()) {
                remark = attElement.getAsString();
            }
            attElement = shop.get("status");
            int status = 0;
            if (!attElement.isJsonNull()) {
                status = attElement.getAsInt();
            }
            ws = new Workshop(id, email, name, description, website, address, openingHour, openingHourFormat,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, status);
        }
        return ws;
    }

    public Workshop retrieveWorkshop(int givenID, int staffId, String token) throws IOException {
        Workshop ws = null;
        String url = "http://119.81.43.85/erp/workshop/get_shop_by_id_or_email";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", givenID + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();

        JsonElement shopElement = jobj.get("payload");
        JsonObject shop = null;
        if (shopElement.isJsonNull()) {
            return ws;
        } else {
            shop = shopElement.getAsJsonObject().getAsJsonObject("shop");
            JsonElement attElement = shop.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = shop.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = shop.get("website");
            String website = "";
            if (!attElement.isJsonNull()) {
                website = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_full");
            String openingHour = "";
            if (!attElement.isJsonNull()) {
                openingHour = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_format");
            String openingHourFormat = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat = attElement.getAsString();
            }
            attElement = shop.get("latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }
            attElement = shop.get("longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }
            attElement = shop.get("contact");
            String contact = "";
            if (!attElement.isJsonNull()) {
                contact = attElement.getAsString();
            }
            attElement = shop.get("contact2");
            String contact2 = "";
            if (!attElement.isJsonNull()) {
                contact2 = attElement.getAsString();
            }
            attElement = shop.get("location");
            String location = "";
            if (!attElement.isJsonNull()) {
                location = attElement.getAsString();
            }
            attElement = shop.get("specialize");
            String specialize = "";
            if (!attElement.isJsonNull()) {
                specialize = attElement.getAsString();
            }
            attElement = shop.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }
            attElement = shop.get("brand_carried");
            String brandsCarried = "";
            if (!attElement.isJsonNull()) {
                brandsCarried = attElement.getAsString();
            }
            attElement = shop.get("remark");
            String remark = "";
            if (!attElement.isJsonNull()) {
                remark = attElement.getAsString();
            }
            attElement = shop.get("status");
            int status = 0;
            if (!attElement.isJsonNull()) {
                status = attElement.getAsInt();
            }
            ws = new Workshop(id, email, name, description, website, address, openingHour, openingHourFormat,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, status);
        }
        return ws;
    }

    public ArrayList<String> addWorkshop(String email, String name, String description, String website, String address, String openingHour, String openingHourFormat, double latitude,
            double longitude, String contact, String contact2, String location, String specialize, String category, String brandsCarried,
            String remark, int staffId, String token) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/workshop/add_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("description", description));
        urlParameters.add(new BasicNameValuePair("website", website));
        urlParameters.add(new BasicNameValuePair("address", address));
        urlParameters.add(new BasicNameValuePair("opening_hour_full", openingHour));
        urlParameters.add(new BasicNameValuePair("opening_hour_format", openingHourFormat));
        urlParameters.add(new BasicNameValuePair("latitude", latitude + ""));
        urlParameters.add(new BasicNameValuePair("longitude", longitude + ""));
        urlParameters.add(new BasicNameValuePair("contact", contact));
        urlParameters.add(new BasicNameValuePair("contact2", contact2));
        urlParameters.add(new BasicNameValuePair("location", location));
        urlParameters.add(new BasicNameValuePair("specialize", specialize));
        urlParameters.add(new BasicNameValuePair("category", category));
        urlParameters.add(new BasicNameValuePair("brand_carried", brandsCarried));
        urlParameters.add(new BasicNameValuePair("remark", remark));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("status", 1 + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        String errorMessage = null;
        ArrayList<String> errors = new ArrayList<String>();
        JsonElement isSuccess = jobj.get("is_success");
        if (isSuccess.getAsString().equals("false")) {
            errorMessage = jobj.get("error_message").getAsString();
            errors.add(errorMessage);
            JsonElement fields = jobj.get("payload");
            if (!fields.isJsonNull()) {
                JsonArray arr = fields.getAsJsonObject().get("error_field").getAsJsonArray();
                for (int i = 0; i < arr.size(); i++) {
                    String f = arr.get(i).getAsString();
                    errors.add(f);
                }
            }
        }

        return errors;

    }

    public ArrayList<Workshop> retrieveAllWorkshops(int staffId, String token) throws UnsupportedEncodingException, IOException {
        ArrayList<Workshop> allWorkshops = new ArrayList<Workshop>();
        String url = "http://119.81.43.85/erp/workshop/get_all_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonArray arr = (jobj.getAsJsonObject("payload")).getAsJsonArray("shops");

        for (int i = 0; i < arr.size(); i++) {
            JsonElement workshop = arr.get(i);
            JsonObject shop = workshop.getAsJsonObject();
            JsonElement attElement = shop.get("id");
            int id = 0;
            if (!attElement.isJsonNull()) {
                id = attElement.getAsInt();
            }
            attElement = shop.get("name");
            String name = "";
            if (!attElement.isJsonNull()) {
                name = attElement.getAsString();
            }
            attElement = shop.get("email");
            String email = "";
            if (!attElement.isJsonNull()) {
                email = attElement.getAsString();
            }
            attElement = shop.get("description");
            String description = "";
            if (!attElement.isJsonNull()) {
                description = attElement.getAsString();
            }
            attElement = shop.get("website");
            String website = "";
            if (!attElement.isJsonNull()) {
                website = attElement.getAsString();
            }
            attElement = shop.get("address");
            String address = "";
            if (!attElement.isJsonNull()) {
                address = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_full");
            String openingHour = "";
            if (!attElement.isJsonNull()) {
                openingHour = attElement.getAsString();
            }
            attElement = shop.get("opening_hour_format");
            String openingHourFormat = "";
            if (!attElement.isJsonNull()) {
                openingHourFormat = attElement.getAsString();
            }
            attElement = shop.get("latitude");
            double latitude = 0.0;
            if (!attElement.isJsonNull()) {
                latitude = attElement.getAsDouble();
            }
            attElement = shop.get("longitude");
            double longitude = 0.0;
            if (!attElement.isJsonNull()) {
                longitude = attElement.getAsDouble();
            }
            attElement = shop.get("contact");
            String contact = "";
            if (!attElement.isJsonNull()) {
                contact = attElement.getAsString();
            }
            attElement = shop.get("contact2");
            String contact2 = "";
            if (!attElement.isJsonNull()) {
                contact2 = attElement.getAsString();
            }
            attElement = shop.get("location");
            String location = "";
            if (!attElement.isJsonNull()) {
                location = attElement.getAsString();
            }
            attElement = shop.get("specialize");
            String specialize = "";
            if (!attElement.isJsonNull()) {
                specialize = attElement.getAsString();
            }
            attElement = shop.get("category");
            String category = "";
            if (!attElement.isJsonNull()) {
                category = attElement.getAsString();
            }
            attElement = shop.get("brand_carried");
            String brandsCarried = "";
            if (!attElement.isJsonNull()) {
                brandsCarried = attElement.getAsString();
            }
            attElement = shop.get("remark");
            String remark = "";
            if (!attElement.isJsonNull()) {
                remark = attElement.getAsString();
            }
            attElement = shop.get("status");
            int status = 0;
            if (!attElement.isJsonNull()) {
                status = attElement.getAsInt();
            }
            //int status = attElement.getAsInt();
            Workshop ws = new Workshop(id, email, name, description, website, address, openingHour, openingHourFormat,
                    latitude, longitude, contact, contact2, location, specialize, category, brandsCarried, remark, status);

            allWorkshops.add(ws);
        }
        return allWorkshops;
    }

    public ArrayList<String> updateWorkshop(int id, String email, String name, String description, String website, String address, String openingHour, String openingHourFormat, double latitude,
            double longitude, String contact, String contact2, String location, String specialize, String category, String brandsCarried,
            String remark, int status, int staffId, String token) throws UnsupportedEncodingException, IOException {

        String url = "http://119.81.43.85/erp/workshop/edit_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));
        urlParameters.add(new BasicNameValuePair("name", name));
        urlParameters.add(new BasicNameValuePair("description", description));
        urlParameters.add(new BasicNameValuePair("website", website));
        urlParameters.add(new BasicNameValuePair("address", address));
        urlParameters.add(new BasicNameValuePair("opening_hour_full", openingHour));
        urlParameters.add(new BasicNameValuePair("opening_hour_format", openingHourFormat));
        urlParameters.add(new BasicNameValuePair("latitude", latitude + ""));
        urlParameters.add(new BasicNameValuePair("longitude", longitude + ""));
        urlParameters.add(new BasicNameValuePair("contact", contact));
        urlParameters.add(new BasicNameValuePair("contact2", contact2));
        urlParameters.add(new BasicNameValuePair("location", location));
        urlParameters.add(new BasicNameValuePair("specialize", specialize));
        urlParameters.add(new BasicNameValuePair("category", category));
        urlParameters.add(new BasicNameValuePair("brand_carried", brandsCarried));
        urlParameters.add(new BasicNameValuePair("remark", remark));
        urlParameters.add(new BasicNameValuePair("email", email));
        urlParameters.add(new BasicNameValuePair("status", 1 + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        String str = result.toString();
        System.out.print(str);
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        String errorMessage = null;
        ArrayList<String> errors = new ArrayList<String>();
        JsonElement isSuccess = jobj.get("is_success");
        if (isSuccess.getAsString().equals("false")) {
            errorMessage = jobj.get("error_message").getAsString();
            errors.add(errorMessage);
            JsonElement fields = jobj.get("payload");
            JsonArray arr;
            if (!fields.isJsonNull()) {
                arr = fields.getAsJsonObject().get("error_field").getAsJsonArray();

                for (int i = 0; i < arr.size(); i++) {
                    String f = arr.get(i).getAsString();
                    errors.add(f);
                }
            }
        }

        return errors;
    }

    public ArrayList<String> retrieveAllCarBrands(int staffId, String token) throws UnsupportedEncodingException, IOException {
        ArrayList<String> carBrands = new ArrayList<String>();
        String url = "http://119.81.43.85/erp/avalible_car/get_all_avalible_car";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();

        JsonElement brandsElement = jobj.get("payload");
        JsonObject brands = null;
        if (brandsElement.isJsonNull()) {
            return carBrands;
        } else {
            brands = brandsElement.getAsJsonObject();
            JsonArray brandsArr = brands.getAsJsonArray("available_cars");
            for (int i = 0; i < brandsArr.size(); i++) {
                JsonElement brandArr = brandsArr.get(i);
                JsonObject brandObj = brandArr.getAsJsonObject();
                JsonElement attElement = brandObj.get("car_brand");
                String brand = "";
                if (!attElement.isJsonNull()) {
                    brand = attElement.getAsString();
                    if (!carBrands.contains(brand)) {
                        carBrands.add(brand);
                    }
                }

            }
        }
        return carBrands;
    }

    //Convert address to latitude and longitude 
    //Latitude = String[0]
    //Longitude = String[1]
    public String[] retrieveLatLong(String address) throws Exception {
        int responseCode = 0;
        String api = "http://maps.googleapis.com/maps/api/geocode/xml?address=" + URLEncoder.encode(address, "UTF-8") + "&sensor=true";
        URL url = new URL(api);
        HttpURLConnection httpConnection = (HttpURLConnection) url.openConnection();
        httpConnection.connect();
        responseCode = httpConnection.getResponseCode();
        if (responseCode == 200) {
            DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();;
            Document document = builder.parse(httpConnection.getInputStream());
            XPathFactory xPathfactory = XPathFactory.newInstance();
            XPath xpath = xPathfactory.newXPath();
            XPathExpression expr = xpath.compile("/GeocodeResponse/status");
            String status = (String) expr.evaluate(document, XPathConstants.STRING);
            if (status.equals("OK")) {
                expr = xpath.compile("//geometry/location/lat");
                String latitude = (String) expr.evaluate(document, XPathConstants.STRING);
                expr = xpath.compile("//geometry/location/lng");
                String longitude = (String) expr.evaluate(document, XPathConstants.STRING);
                return new String[]{latitude, longitude};
            } else {
                return null;
            }
        }
        return null;
    }

    public String deleteWorkshop(int staffId, String token, int id) throws UnsupportedEncodingException, IOException {
        String url = "http://119.81.43.85/erp/workshop/delete_shop";

        HttpClient client = new DefaultHttpClient();
        HttpPost post = new HttpPost(url);

        // add header
        post.setHeader("User-Agent", USER_AGENT);

        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
        urlParameters.add(new BasicNameValuePair("staff_id", staffId + ""));
        urlParameters.add(new BasicNameValuePair("token", token));
        urlParameters.add(new BasicNameValuePair("id", id + ""));

        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        HttpResponse response = client.execute(post);
        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        String str = result.toString();
        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(str);
        JsonObject jobj = element.getAsJsonObject();
        JsonElement errMsgEle = jobj.get("error_message");
        String errMsg = "";
        if (errMsgEle != null && !errMsgEle.isJsonNull()) {
            errMsg = errMsgEle.getAsString();
        }
        return errMsg;
    }

    public static void main(String[] args) throws IOException {
//        String openingHr = "Monday-0900-1800,Tuesday-0900-1800,Wednesday-0900-1800,Thursday-0900-1800,Friday-0900-1800,Saturday-0900-1400,Sunday-Closed-Closed,Ph-Closed-Closed,PhEve-0000-0000";
//        ArrayList<String> compiled = new ArrayList<String>();
//        //Monday-0900-1800
//        String[] daysAndTime = openingHr.split(",");
//        //openCloseTimings[0] = Monday, openCloseTimings[1] = 0900, openCloseTimings[2] = 1800
//        String[] openCloseTimings = daysAndTime[0].split("-");
//        String dayToCompare = openCloseTimings[0];
//        String openToCompare = openCloseTimings[1];
//        String closeToCompare = openCloseTimings[2];
//        String toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;
//
//        for (int i = 1; i < daysAndTime.length - 2; i++) {
//            openCloseTimings = daysAndTime[i].split("-");
//            if (openCloseTimings[1].equals(openToCompare) && openCloseTimings[2].equals(closeToCompare)) {
//                String[] toAddArr = toAdd.split("-");
//                toAdd = toAddArr[0] + "-" + openCloseTimings[0] + "-" + openToCompare + "-" + closeToCompare;
//            } else {
//                String[] toAddArr = toAdd.split("-");
//                //Closed-Closed
//                if (toAddArr[2].equals("Closed")) {
//                    //Saturday-Saturday
//                    if (toAddArr[0].equals(toAddArr[1])) {
//                        toAdd = toAddArr[0] + ": Closed";
//                    } else {
//                        toAdd = toAddArr[0] + " to " + toAddArr[1] + ": Closed";
//                    }
//                } else //Saturday-Saturday
//                {
//                    if (toAddArr[0].equals(toAddArr[1])) {
//                        toAdd = toAddArr[0] + ": " + toAddArr[2] + " - " + toAddArr[3];
//                    } else {
//                        toAdd = toAddArr[0] + " to " + toAddArr[1] + ": " + toAddArr[2] + " - " + toAddArr[3];
//                    }
//                }
//                compiled.add(toAdd);
//                dayToCompare = openCloseTimings[0];
//                openToCompare = openCloseTimings[1];
//                closeToCompare = openCloseTimings[2];
//                toAdd = dayToCompare + "-" + dayToCompare + "-" + openToCompare + "-" + closeToCompare;
//            }
//
//            if (i == daysAndTime.length - 3) {
//                String[] toAddArr = toAdd.split("-");
//                //Closed-Closed
//                if (toAddArr[2].equals("Closed")) {
//                    //Saturday-Saturday
//                    if (toAddArr[0].equals(toAddArr[1])) {
//                        toAdd = toAddArr[0] + ": Closed";
//                    } else {
//                        toAdd = toAddArr[0] + " to " + toAddArr[1] + ": Closed";
//                    }
//                } else //Saturday-Saturday
//                {
//                    if (toAddArr[0].equals(toAddArr[1])) {
//                        toAdd = toAddArr[0] + ": " + toAddArr[2] + " - " + toAddArr[3];
//                    } else {
//                        toAdd = toAddArr[0] + " to " + toAddArr[1] + ": " + toAddArr[2] + " - " + toAddArr[3];
//                    }
//                }
//                compiled.add(toAdd);
//            }
//        }
//
//        for (int i = 7; i < 9; i++) {
//            openCloseTimings = daysAndTime[i].split("-");
//            //Closed-Closed
//            if (openCloseTimings[2].equals("Closed")) {
//                toAdd = openCloseTimings[0] + ": Closed";
//            } else {
//                toAdd = openCloseTimings[0] + ": " + openCloseTimings[1] + " - " + openCloseTimings[2];
//            }
//            compiled.add(toAdd);
//        }
//        for (String x : compiled) {
//            System.out.println(x);
//        }
    }
}
