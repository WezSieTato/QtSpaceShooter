.pragma library
.import QtQuick 2.0 as QQ
.import "Helpers.js" as Helper

var game;
var asteroidClock = 300
var enemyShipClock = 600
var powerUpClock = 900

function update() {
    var toDestroy = new Array();
    //Kolizje
    game.asteroids.forEach(function(asteroid){
        if (Helper.isCollide(game.ship, asteroid)){
            toDestroy.push(asteroid)
            game.ship.getShot()
        }
        else{
            game.friendlyMissiles.some(function(missile){
                if(Helper.isCollide(missile,asteroid)){
                    toDestroy.push(missile);
                    toDestroy.push(asteroid);
                    game.ship.point += asteroid.pointValue
                    return true
                }
            })
        }
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

    game.enemyMissiles.forEach(function(missile){
        if (Helper.isCollide(game.ship, missile)){
            toDestroy.push(missile);
            game.ship.getShot()
        }

    });

    game.powerUps.forEach(function(powerUp){
        if (Helper.isCollide(game.ship, powerUp)){
            toDestroy.push(powerUp);
            game.ship.hp += powerUp.hp
            game.sounds.playPowerUp()
        }

    });

    //Niszczenie
    var len = toDestroy.length
    for(var i = 0; i < len; ++i){
        var victim = toDestroy.pop();
        remove(victim)
    }


    //Spawnowanie nowych
    if(asteroidClock > 0){
        asteroidClock--;
    } else {
        asteroidClock = Helper.randomFromInterval(60, 120);
        game.createAsteroid();
    }

    if(enemyShipClock > 0){
        enemyShipClock--
    } else {
        var newShip = true
        game.enemyShips.some(function(ship){
            if(isBlockingSpawn(ship)){
                newShip = false
                return true
            }
        })

        if(newShip){
            enemyShipClock = Helper.randomFromInterval(100, 300);
            game.createEnemyShip();
        }
    }

    if(powerUpClock > 0){
        powerUpClock--
    } else {
        powerUpClock = Helper.randomFromInterval(1000, 2000);
        game.createPowerUp();
    }

}

function remove(victim){
    if(! checkOrRemove(game.friendlyMissiles, victim))
        if(!checkOrRemove(game.asteroids, victim))
            if(!checkOrRemove(game.enemyShips, victim))
                if(!checkOrRemove(game.enemyMissiles, victim))
                    checkOrRemove(game.powerUps, victim)

//    console.log("Ilosc efriendlyMissiles: " + game.friendlyMissiles.length)
    victim.destroy();
}

function checkOrRemove(list, victim){
    var index = list.indexOf(victim);
    if(index >= 0){
        list.splice(index, 1);
        return true
    }
    return false
}

function isBlockingSpawn(ship){
    return !(   ship.x + ship.width < game.width - ship.width  ||
                game.width < ship.x  ||
                 ship.y + ship.height < -ship.height  ||
                 0 < ship.y)
}

function prepare(newGame){
    game = newGame
    game.friendlyMissiles = new Array()
    game.asteroids = new Array()
    game.enemyShips = new Array()
    game.enemyMissiles = new Array()
    game.powerUps = new Array()
}

function clean(){
    asteroidClock = 300
    enemyShipClock = 600
    powerUpClock = 900

    cleanArrat( game.friendlyMissiles)
    cleanArrat( game.asteroids)
    cleanArrat( game.enemyShips)
    cleanArrat( game.enemyMissiles)
    cleanArrat( game.powerUps)
}

function cleanArrat(array){
    var len = array.length
    for(var i = 0; i < len; ++i){
        var victim = array.pop();
        victim.destroy()
    }
    delete array
}
