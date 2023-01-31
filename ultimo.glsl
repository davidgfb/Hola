float map(vec3 p) {
    return length(p) - 0.5;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    /*OBJ: uv normaliza la pos del pixel en pantalla entre [0, 1]
    El origen esta en la esq inf izda!
    fragCoord = pos pixel en pantalla
    iResolution = resolucion pantalla
    ej: 1er pixel: (0.5, 0.5) / (1920, 1080) = (0, 0)
    n-esimo pixel: (1919'5, 1079'5) / (1920, 1080) =
    = (1, 1)    
    */
    vec2 uv = fragCoord / iResolution.xy; 
    vec3 ro = vec3(0, 0, 1),
        rd = normalize(vec3((2.0 * uv - 1.0) * 
        vec2(iResolution.x / iResolution.y, 1), -1.0)),
        color = vec3(0);
    float tMin = map(ro),
        t = tMin;
    bool bHit = false;
            
    while (!bHit && t <= tMin) {
        ro += rd * t;
        t = map(ro);
        bHit = t < 1e-3; 
    }
    
    fragColor = vec4(vec3(int(bHit)), 1);    
}