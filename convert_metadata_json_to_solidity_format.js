'use strict';

const fs = require('fs');

fs.readFile('metadata.json', (err, data) => {
    if (err) throw err;
    let records = JSON.parse(data);
    // console.log(records);
    for (let index = 0; index < records.length; index++) {
        const element = records[index];

        if(element.CODE.includes("SH")){
            console.log(`
            info["`+element.CODE+`"][HP] = `+element.HP*10000+`;
            info["`+element.CODE+`"][ATK] = `+element.ATK*10000+`;
            info["`+element.CODE+`"][DEF] = `+element.DEF*10000+`;
            info["`+element.CODE+`"][ASPD] = `+element.ASPD*10000+`;
            info["`+element.CODE+`"][RANGE] = `+element.RANGE*10000+`;
            info["`+element.CODE+`"][BONUS_HP] = `+element.BONUS_HP*10000+`;
            info["`+element.CODE+`"][BONUS_ATK] = `+element.BONUS_ATK*10000+`;
            info["`+element.CODE+`"][BONUS_DEF] = `+element.BONUS_DEF*10000+`;
            info["`+element.CODE+`"][BONUS_ASPD] = `+element.BONUS_ASPD*10000+`;
            info["`+element.CODE+`"][CRIT] = `+element.CRIT*10000+`;
            info["`+element.CODE+`"][DODGE] = `+element.DODGE*10000+`;
            info["`+element.CODE+`"][LIFESTEAL] = `+element.LIFESTEAL*10000+`;
            info["`+element.NAME+`"][NAME] = "`+element.NAME+`";`
            )
        }        
    }
});
 