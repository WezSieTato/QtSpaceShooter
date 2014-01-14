.pragma library
.import QtQuick 2.0 as QQ
.import "Helpers.js" as Helper

var game;
var asteroidClock = 0
var enemyShipClock = 0

function update() {
    var toDestroy = new Array();
    game.friendlyMissiles.forEach(function(missile){
        if (missile.x > game.width)
            toDestroy.push(missile);

    })

    game.asteroids.forEach(function(asteroid){
        //        console.log(asteroid.x)
//        if(asteroid.x + asteroid.width < 0){
//            toDestroy.push(asteroid)
//        } else {

            if (Helper.isCollide(game.ship, asteroid)){
                toDestroy.push(asteroid)
                game.ship.getShot()
            }
            else{

                game.friendlyMissiles.some(function(missile){
                    if(Helper.isCollide(missile,asteroid)){
//                        console.log("Zderzenie")
                        toDestroy.push(missile);
                        toDestroy.push(asteroid);
                        game.ship.point += asteroid.pointValue
                        return true
                    }
                })
            }
//        }
    });

    game.enemyShips.forEach(function(enemy){

        if (Helper.isCollide(game.ship, enemy)){
            toDestroy.push(enemy);
            game.ship.getShot()
            enemy.getShot()
        }
        else{
            game.friendlyMissiles.some(function(missile){
                if(Helper.isCollide(missile,enemy)){

                    toDestroy.push(missile);
                    if(enemy.getShot()){
                        game.ship.point += enemy.pointValue
                        toDestroy.push(enemy);
                    }

                    return true
                }
            })
        }

    });

    var len = toDestroy.length
    for(var i = 0; i < len; ++i){
        var victim = toDestroy.pop();
        remove(victim)
    }

    if(asteroidClock > 0){
        asteroidClock--;
    } else {
        asteroidClock = Helper.randomFromInterval(60, 120);
        game.createAsteroid();
    }

    if(enemyShipClock > 0){
        enemyShipClock--
    } else {
        enemyShipClock = Helper.randomFromInterval(100, 300);
        game.createEnemyShip();
    }

}

function remove(victim){
    var index = game.friendlyMissiles.indexOf(victim);
    if(index >= 0){
        game.friendlyMissiles.splice(index, 1);
    }

    index = game.asteroids.indexOf(victim);
    if(index >= 0){
        game.asteroids.splice(index, 1);
    }

    index = game.enemyShips.indexOf(victim);
    if(index >= 0){
        game.enemyShips.splice(index, 1);
    }

    index = game.enemyMissiles.indexOf(victim);
    if(index >= 0){
        game.enemyMissiles.splice(index, 1);
    }

    victim.destroy();
}



