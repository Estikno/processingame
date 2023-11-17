Minim se;

void audio(String name){
  AudioSample sonido = se.loadSample(name);
  sonido.trigger();
}
