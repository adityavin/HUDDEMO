/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class UpdateAccountLocationBasedOnAddressBatch implements Database.AllowsCallouts, Database.Batchable<SObject> {
    global UpdateAccountLocationBasedOnAddressBatch() {

    }
    global void execute(Database.BatchableContext context, List<Account> scope) {

    }
    global void finish(Database.BatchableContext context) {

    }
    global Database.QueryLocator start(Database.BatchableContext context) {
        return null;
    }
global class GeometryClass {
    global ExAM.UpdateAccountLocationBasedOnAddressBatch.LocationClass location;
    global GeometryClass() {

    }
}
global class LatLngConversion {
    global ExAM.UpdateAccountLocationBasedOnAddressBatch.GeometryClass geometry;
    global LatLngConversion() {

    }
}
global class LatLngConversionResult {
    global String error_message;
    global List<ExAM.UpdateAccountLocationBasedOnAddressBatch.LatLngConversion> results;
    global String status;
    global LatLngConversionResult() {

    }
}
global class LocationClass {
    global String lat;
    global String lng;
    global LocationClass() {

    }
}
}
