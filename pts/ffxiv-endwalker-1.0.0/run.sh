#!/bin/bash
set -o errexit -o pipefail -o nounset -o noclobber

ARGS="$(getopt -o "w:h:m:q:" -n "$0" -- "$@")"
eval set -- "$ARGS"
WIDTH= HEIGHT= MODE= QUALITY=
while true; do
    case "$1" in
        -w) WIDTH="$2"; shift 2;;
        -h) HEIGHT="$2"; shift 2;;
        -m) MODE="$2"; shift 2;;
        -q) QUALITY="$2"; shift 2;;
        --) shift; break;;
        *)  echo "Internal error!" >&2; exit 1;;
    esac
done

CONFIG=("[EVN]")
CMDLINE=(SYS.Language=0 SYS.Fps=0)

if [ -z "$WIDTH" -o -z "$HEIGHT" ]; then
    echo "Missing -w <width> or -h <height>" >&2
    exit 1
fi
CMDLINE+=(SYS.ScreenWidth="$WIDTH" SYS.ScreenHeight="$HEIGHT" SYS.FullScreenWidth="$WIDTH" SYS.FullScreenHeight="$HEIGHT")

case "$MODE" in
    fullscreen) CMDLINE+=(SYS.ScreenMode=1);;
    windowed)   CMDLINE+=(SYS.ScreenMode=0);;
    borderless) CMDLINE+=(SYS.ScreenMode=2);;
    *) echo "Missing -m fullscreen|windowed|borderless" >&2; exit 1;;
esac

case "$QUALITY" in
    maximum)
        CONFIG+=(SPEC_DX11=0)
        CMDLINE+=(
            SYS.WaterWet_DX11=1
            SYS.OcclusionCulling_DX11=0
            SYS.LodType_DX11=0
            SYS.ReflectionType_DX11=3
            SYS.AntiAliasing_DX11=1
            SYS.TranslucentQuality_DX11=1
            SYS.GrassQuality_DX11=3
            SYS.ShadowLOD_DX11=0
            SYS.ShadowVisibilityTypeSelf_DX11=1
            SYS.ShadowVisibilityTypeOther_DX11=1
            SYS.ShadowTextureSizeType_DX11=2
            SYS.ShadowCascadeCountType_DX11=2
            SYS.ShadowSoftShadowType_DX11=1
            SYS.PhysicsTypeSelf_DX11=2
            SYS.PhysicsTypeOther_DX11=2
            SYS.TextureFilterQuality_DX11=2
            SYS.TextureAnisotropicQuality_DX11=2
            SYS.Vignetting_DX11=1
            SYS.RadialBlur_DX11=1
            SYS.SSAO_DX11=4
            SYS.Glare_DX11=2
            SYS.DepthOfField_DX11=1
            SYS.ParallaxOcclusion_DX11=1
            SYS.Tessellation_DX11=1
            SYS.GlareRepresentation_DX11=1
            SYS.DistortionWater_DX11=2
        )
        ;;
    high-desktop)
        CONFIG+=(SPEC_DX11=1)
        CMDLINE+=(
            SYS.WaterWet_DX11=1
            SYS.OcclusionCulling_DX11=1
            SYS.LodType_DX11=0
            SYS.ReflectionType_DX11=3
            SYS.AntiAliasing_DX11=1
            SYS.TranslucentQuality_DX11=1
            SYS.GrassQuality_DX11=3
            SYS.ShadowLOD_DX11=1
            SYS.ShadowVisibilityTypeSelf_DX11=1
            SYS.ShadowVisibilityTypeOther_DX11=1
            SYS.ShadowTextureSizeType_DX11=2
            SYS.ShadowCascadeCountType_DX11=2
            SYS.ShadowSoftShadowType_DX11=1
            SYS.PhysicsTypeSelf_DX11=2
            SYS.PhysicsTypeOther_DX11=2
            SYS.TextureFilterQuality_DX11=2
            SYS.TextureAnisotropicQuality_DX11=1
            SYS.Vignetting_DX11=1
            SYS.RadialBlur_DX11=1
            SYS.SSAO_DX11=3
            SYS.Glare_DX11=2
            SYS.DepthOfField_DX11=1
            SYS.ParallaxOcclusion_DX11=1
            SYS.Tessellation_DX11=1
            SYS.GlareRepresentation_DX11=1
            SYS.DistortionWater_DX11=2
        )
        ;;
    high-laptop)
        CONFIG+=(SPEC_DX11=2)
        CMDLINE+=(
            SYS.WaterWet_DX11=1
            SYS.OcclusionCulling_DX11=1
            SYS.LodType_DX11=1
            SYS.ReflectionType_DX11=0
            SYS.AntiAliasing_DX11=1
            SYS.TranslucentQuality_DX11=0
            SYS.GrassQuality_DX11=2
            SYS.ShadowLOD_DX11=1
            SYS.ShadowVisibilityTypeSelf_DX11=1
            SYS.ShadowVisibilityTypeOther_DX11=1
            SYS.ShadowTextureSizeType_DX11=1
            SYS.ShadowCascadeCountType_DX11=2
            SYS.ShadowSoftShadowType_DX11=1
            SYS.PhysicsTypeSelf_DX11=2
            SYS.PhysicsTypeOther_DX11=2
            SYS.TextureFilterQuality_DX11=2
            SYS.TextureAnisotropicQuality_DX11=0
            SYS.Vignetting_DX11=1
            SYS.RadialBlur_DX11=1
            SYS.SSAO_DX11=3
            SYS.Glare_DX11=2
            SYS.DepthOfField_DX11=1
            SYS.ParallaxOcclusion_DX11=1
            SYS.Tessellation_DX11=1
            SYS.GlareRepresentation_DX11=0
            SYS.DistortionWater_DX11=2
        )
        ;;
    standard-desktop)
        CONFIG+=(SPEC_DX11=3)
        CMDLINE+=(
            SYS.WaterWet_DX11=1
            SYS.OcclusionCulling_DX11=1
            SYS.LodType_DX11=1
            SYS.ReflectionType_DX11=0
            SYS.AntiAliasing_DX11=0
            SYS.TranslucentQuality_DX11=0
            SYS.GrassQuality_DX11=1
            SYS.ShadowLOD_DX11=1
            SYS.ShadowVisibilityTypeSelf_DX11=1
            SYS.ShadowVisibilityTypeOther_DX11=0
            SYS.ShadowTextureSizeType_DX11=1
            SYS.ShadowCascadeCountType_DX11=1
            SYS.ShadowSoftShadowType_DX11=0
            SYS.PhysicsTypeSelf_DX11=2
            SYS.PhysicsTypeOther_DX11=1
            SYS.TextureFilterQuality_DX11=1
            SYS.TextureAnisotropicQuality_DX11=0
            SYS.Vignetting_DX11=0
            SYS.RadialBlur_DX11=1
            SYS.SSAO_DX11=0
            SYS.Glare_DX11=2
            SYS.DepthOfField_DX11=1
            SYS.ParallaxOcclusion_DX11=0
            SYS.Tessellation_DX11=0
            SYS.GlareRepresentation_DX11=0
            SYS.DistortionWater_DX11=2
        )
        ;;
    standard-laptop)
        CONFIG+=(SPEC_DX11=4)
        CMDLINE+=(
            SYS.WaterWet_DX11=1
            SYS.OcclusionCulling_DX11=1
            SYS.LodType_DX11=1
            SYS.ReflectionType_DX11=0
            SYS.AntiAliasing_DX11=0
            SYS.TranslucentQuality_DX11=0
            SYS.GrassQuality_DX11=1
            SYS.ShadowLOD_DX11=1
            SYS.ShadowVisibilityTypeSelf_DX11=1
            SYS.ShadowVisibilityTypeOther_DX11=0
            SYS.ShadowTextureSizeType_DX11=1
            SYS.ShadowCascadeCountType_DX11=1
            SYS.ShadowSoftShadowType_DX11=0
            SYS.PhysicsTypeSelf_DX11=2
            SYS.PhysicsTypeOther_DX11=0
            SYS.TextureFilterQuality_DX11=1
            SYS.TextureAnisotropicQuality_DX11=0
            SYS.Vignetting_DX11=0
            SYS.RadialBlur_DX11=1
            SYS.SSAO_DX11=0
            SYS.Glare_DX11=2
            SYS.DepthOfField_DX11=1
            SYS.ParallaxOcclusion_DX11=0
            SYS.Tessellation_DX11=0
            SYS.GlareRepresentation_DX11=0
            SYS.DistortionWater_DX11=2
        )
        ;;
    *)
        echo "Missing -q maximum|high-desktop|high-laptop|standard-desktop|standard-laptop" >&2
        exit 1
        ;;
esac

declare -A CMDLINE2CONFIG=(
    [SYS.Language]=LANGUAGE
    [SYS.ScreenWidth]=SCREENWIDTH_DX11
    [SYS.ScreenHeight]=SCREENHEIGHT_DX11
    [SYS.ScreenMode]=SCREENMODE_DX11

    [SYS.WaterWet_DX11]=WaterWetness_DX11
    [SYS.OcclusionCulling_DX11]=OcclusionCulling_DX11
    [SYS.LodType_DX11]=LodType_DX11
    [SYS.ReflectionType_DX11]=ReflectionType_DX11
    [SYS.AntiAliasing_DX11]=AntiAliasing_DX11
    [SYS.TranslucentQuality_DX11]=TranslucentQuality_DX11
    [SYS.GrassQuality_DX11]=GrassQuality_DX11
    [SYS.ShadowLOD_DX11]=ShadowLOD_DX11
    [SYS.ShadowVisibilityTypeSelf_DX11]=ShadowVisibilityTypeSelf_DX11
    [SYS.ShadowVisibilityTypeOther_DX11]=ShadowVisibilityTypeOther_DX11
    [SYS.ShadowTextureSizeType_DX11]=ShadowTextureSizeType_DX11
    [SYS.ShadowCascadeCountType_DX11]=ShadowCascadeCountType_DX11
    [SYS.ShadowSoftShadowType_DX11]=ShadowSoftShadowType_DX11
    [SYS.PhysicsTypeSelf_DX11]=PhysicsTypeSelf_DX11
    [SYS.PhysicsTypeOther_DX11]=PhysicsTypeOther_DX11
    [SYS.TextureFilterQuality_DX11]=TextureFilterQuality_DX11
    [SYS.TextureAnisotropicQuality_DX11]=TextureAnisotropicQuality_DX11
    [SYS.Vignetting_DX11]=Vignetting_DX11
    [SYS.RadialBlur_DX11]=RadialBlur_DX11
    [SYS.SSAO_DX11]=SSAO_DX11
    [SYS.Glare_DX11]=Glare_DX11
    [SYS.DepthOfField_DX11]=DepthOfField_DX11
    [SYS.ParallaxOcclusion_DX11]=Parallax_DX11
    [SYS.Tessellation_DX11]=WaterTess_DX11
    [SYS.GlareRepresentation_DX11]=GlareRepresentation_DX11
    [SYS.DistortionWater_DX11]=DistortionWater_DX11
)
for ARG in "${CMDLINE[@]}"; do
    KEY="${ARG%%=*}"
    VALUE="${ARG#*=}"
    if [[ -v "CMDLINE2CONFIG[$KEY]" ]]; then
        CONFIG+=("${CMDLINE2CONFIG[$KEY]}=$VALUE")
    fi
done

cd ffxiv-endwalker-bench
rm -f ffxivbenchmarklauncher.ini
(IFS=$'\n'; echo "${CONFIG[*]}" > ffxivbenchmarklauncher.ini)
${USE_WINE:-} game/ffxiv_dx11.exe "${CMDLINE[@]}" "$@"
grep -E "SCORE(_FPSAVERAGE)?=" ffxivbenchmarklauncher.ini > "$LOG_FILE"
