var express = require('express');
var router = express.Router();

/*
 * GET programlist.
 */
router.get('/getprogram', function(req, res) {
    var params = req.query;    
    
    if(params.client == undefined || params.client.trim() == "") {
        res.send({"error":true, "message":"Client must required."});        
    } else if(params.language == undefined || params.language.trim() == "") {
        res.send({"error":true, "message":"Language must required."});        
    }
    
    var limit = '';
    if((params.from != undefined || params.from > 0) || (params.to != undefined || params.to > 0)) {
        limit = " LIMIT "+params.from+", "+params.to+" ";
    }
    var db = req.db;
    var sql = "SELECT l.lang_name, p.program_name, c.cat_name, p.program_description, pd.code, pd.isrunnable, io.input, io.output"
                + " from language as l JOIN program_details as pd ON l.id = pd.lang_id "  
                + " JOIN program as p ON p.id = pd.prog_id " 
                + " JOIN category as c ON p.program_category = c.id "
                + " JOIN program_io as io ON io.prog_id = pd.id "
                + " WHERE l.lang_name = '"+params.language+"' ORDER BY p.id ASC "+limit;

    db.query(sql, function (err, result) {
        var myresult = {};
        myresult.language = '';        
        myresult.name = [];        
        myresult.category = [];        
        myresult.desc = [];        
        myresult.program = [];        
        myresult.output = [];        
        myresult.input = [];
        myresult.runnable = [];
         
        if (err) {
            myresult.message = 'Failure'; 
            myresult.reason = err.sqlMessage; 
            res.send(myresult);            
        };
        
        var log = "INSERT into requesting (versionno, client, appname, language, timestamp) VALUES "
         + "('"+params.version+"', '"+params.client+"', '"+params.app+"', '"+params.language+"', NOW())";
         db.query(log, function (err, logresult) {
            if(err) {
                myresult.message = 'Failure'; 
                myresult.reason = err.sqlMessage; 
                res.send(myresult);
            } else {
                for(var i = 0; i < result.length; i++) {            
                    myresult.language = result[i].lang_name;
                    myresult.name.push(result[i].program_name);                    
                    myresult.category.push(result[i].cat_name);                    
                    myresult.desc.push(result[i].program_description);                    
                    myresult.program.push(result[i].code);                    
                    myresult.output.push(result[i].output);                    
                    myresult.input.push(result[i].input);                    
                    myresult.runnable.push(result[i].isrunnable);                    
                }        
                myresult.message = 'Success'; 
                myresult.reason = ""; 
                res.send(myresult);
            }
         });        
    });
});

/*
 * POST to add program.
 */
router.post('/saveprogram', function(req, res) {    
    var body = req.body;
    if(body.programname == undefined || body.programname.trim() == "") {
        res.send({"error":true, "message":"Program name must required."});        
    } else if(body.code == undefined || body.code.trim() == "") {
        res.send({"error":true, "message":"Code must required."});        
    } else if(body.programcategory == undefined || body.programcategory.trim() == "") {
        res.send({"error":true, "message":"Program category must required."});        
    }    
    var db = req.db;    
    //var title = ["programname","programdescription","programcategory","Descimagebase64","Descimageurl","code","exampleoutput","difficultylevel","input","output","Isrunnable"];    
    var sql = "CALL saveprogram('"+body.programname+"', '"+body.programdescription+"', '"+body.programcategory+"', '"+body.Descimagebase64+"', '"+body.Descimageurl+"', '"+body.code+"', '"+body.exampleoutput+"', '"+body.difficultylevel+"', '"+body.input+"', '"+body.output+"', '"+body.Isrunnable+"')";    
    
    db.query(sql, function (err, result) {
        if (err) {
            res.send({"error":true, "message":err.sqlMessage});            
        };
        res.send({"error":false, "message":"Saved successfully"});
    });    
});

module.exports = router;