.pragma library
.import QtQuick 2.0 as QQ
.import "Helpers.js" as Helper

var game;
//var ship;
var asteroidClock = 0

Array.prototype.remove = function(from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
    this.length = from < 0 ? this.length + from : from;
    return this.push.apply(this, rest);
};

function update() {
    var toDestroy = new Array();
    game.friendlyMissiles.forEach(function(missile){
        if (missile.x > game.width)
            toDestroy.push(missile);

    })

    game.asteroids.forEach(function(asteroid){
        //        console.log(asteroid.x)
        if(asteroid.x + asteroid.width < 0){
            toDestroy.push(asteroid)
        } else {

            if (Helper.isCollide(game.ship, asteroid)){
                toDestroy.push(asteroid)
                game.ship.getShot()
            }
            else{

                game.friendlyMissiles.some(function(missile){
                    if(Helper.isCollide(missile,asteroid)){
                        console.log("Zderzenie")
                        toDestroy.push(missile);
                        toDestroy.push(asteroid);
                        game.ship.point += asteroid.pointValue
                        return true
                    }
                })
            }
        }
    });

    var len = toDestroy.length
    for(var i = 0; i < len; ++i){
        var victim = toDestroy.pop();
        var index = game.friendlyMissiles.indexOf(victim);
        if(index >= 0){
            game.friendlyMissiles.splice(index, 1);
        }

        index = game.asteroids.indexOf(victim);
        if(index >= 0){
            game.asteroids.splice(index, 1);
        }

        victim.destroy();

        //        console.log("usuwam ilosc laserow" + game.asteroids.length )
    }

    if(asteroidClock > 0){
        asteroidClock--;
    } else {
        asteroidClock = Helper.randomFromInterval(60, 120);
        game.createAsteroid();
    }

}



