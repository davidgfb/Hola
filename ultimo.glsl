float map(vec3 p) {
    return length(p) - 0.5;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    /*OBJ: fragCoord / iResolution.xy (uv) normaliza 
    la pos del pixel en pantalla entre [0, 1]
    El origen esta en la esq inf izda!
    fragCoord = pos pixel en pantalla
    iResolution = resolucion pantalla
    ej: 1er pixel esq inf izda: (0.5, 0.5) / 
    (1920, 1080) = (0, 0)    
    n-esimo pixel esq sup dcha: (1919'5, 1079'5) / 
    (1920, 1080) = (1, 1)  
    
    rd normaliza uv entre [-1, 1]
    ej: (0, 0): 2 * (0, 0) - (1, 1) = 
    (0, 0) - (1, 1) = (-1, -1) 
    (1, 1): 2 * (1, 1) - (1, 1) = (2, 2) - (1, 1) =
    = (1, 1) 
    iResolution.x / iResolution.y corrige la 
    relacion de aspecto
    normalize coordenadas: euclideas --> polares    
    rd = rd.xzy transforma xyz en xzy (el frente 
    esta en (0, 1, 0))
    TODO: origen en esq sup izda
    */
    vec3 ro = vec3(0, -1, 0),
        rd = normalize(vec3(vec2(iResolution.x / 
        iResolution.y, 1) * (2.0 / iResolution.xy * 
        fragCoord - vec2(1)), 1.0)),
        color = vec3(0);    
    float tMin = map(ro),
        t = tMin;
    bool bHit = false;
         
    rd = rd.xzy; 
         
    while (!bHit && t <= tMin) {
        ro += rd * t;
        t = map(ro); 
        bHit = t < 1e-3; 
    }
    
    fragColor = vec4(vec3(int(bHit)), 1);    
}
