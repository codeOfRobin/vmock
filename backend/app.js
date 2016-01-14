var express = require("express")
var app = express()
var router       = express.Router()


app.post('/',function (req,res)
{
    res.json({
        sections:
        [
            {
                x:0,
                y:0,
                height:200,
                analysis:
                [
                        "Collaboratively administrate empowered markets via plug-and-play networks. Dynamically procrastinate B2C users after installed base benefits.",
                        "Efficiently unleash cross-media information without cross-media value.",
                        "Completely synergize resource taxing relationships via premier niche markets."
                ]   
            },
            {
                x:0,
                y:200,
                height:200,
                analysis:
                [
                        "Efficiently unleash cross-media information without cross-media value.",
                        "Collaboratively administrate empowered markets via plug-and-play networks. Dynamically procrastinate B2C users after installed base benefits.",
                        "Completely synergize resource taxing relationships via premier niche markets."
                ]
            },
            {
                x:0,
                y:400,
                height:102,
                analysis:
                [
                        "Completely synergize resource taxing relationships via premier niche markets.",
                        "Efficiently unleash cross-media information without cross-media value.",
                        "Collaboratively administrate empowered markets via plug-and-play networks. Dynamically procrastinate B2C users after installed base benefits."
                ]
            }    
        ]
    })
})

app.listen(3000)