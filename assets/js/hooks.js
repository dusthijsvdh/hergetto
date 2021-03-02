import Player from './player'

let Hooks = {}
let player = {};
// Player
Hooks.vid_player = {
    mounted() {
        player = new Player(this.el.firstChild.nextElementSibling.id, this)
        this.handleEvent('change_vid', (event) => {
            console.log('change video:', event)
            player.setCurrentVideoById(event.cur_vid, event.start_time)
        })

        this.handleEvent('play_video', (event) => {
            console.log('play video:', event)
            player.playVideo(event.playback_position)
        })

        this.handleEvent('pause_video', (event) => {
            console.log('pause video:', event)
            player.pauseVideo()
        })

        this.handleEvent('change_playback_rate', (event) => {
            console.log('change playback rate:', event)
            player.setPlaybackRate(event.playback_rate)
        })

        this.handleEvent('update_playback_position', (event) => {
            console.log('update playback position')
            this.pushEvent('update_playback_position', {'playback_position': player.getCurrentTime()})
        })
    },

    destroyed() {
        if (player.player) {
            player.deconstruct()
        }
        player = {}
        console.log('destroyed')
    }
}

export default Hooks