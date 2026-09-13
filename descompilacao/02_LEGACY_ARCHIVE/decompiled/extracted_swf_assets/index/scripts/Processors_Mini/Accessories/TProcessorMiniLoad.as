package Processors_Mini.Accessories
{
   import Foundation_Mini.Utilities.*;
   import Logics.Agent.*;
   import Logics.Agent.Spaces.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   use namespace ParametersSpace;
   
   public class TProcessorMiniLoad extends Sprite
   {
      
      public static var STAGE_Width:Number = 1250;
      
      public static var STAGE_Height:Number = 650;
      
      protected static const STRING_LoadXMLUrl:String = "resource";
      
      protected static const STRING_LoadMainUrl:String = "TApplication.swf";
      
      public static const RESOURCE_ClassName_MC_Loading:String = "MC_Loading";
      
      public static const RESOURCE_Link_MC_Head:String = "MC_Head";
      
      public static const RESOURCE_Link_MC_ProgressBigBar01:String = "MC_ProgressBigBar01";
      
      public static const RESOURCE_Link_MC_ProgressBigBar02:String = "MC_ProgressBigBar02";
      
      public static const RESOURCE_Link_MC_ProgressBigBar:String = "MC_ProgressBigBar";
      
      public static const RESOURCE_Link_TF_ProgressBig:String = "TF_ProgressBig";
      
      public static const RESOURCE_Link_TF_ProgressSmall:String = "TF_ProgressSmall";
      
      public static const RESOURCE_Link_MC_Fading:String = "MC_Fading";
      
      public static const RESOURCE_Link_MC_ProgressSmallBar01:String = "MC_ProgressSmallBar01";
      
      public static const RESOURCE_Link_MC_ProgressSmallBar:String = "MC_ProgressSmallBar";
      
      public static const RESOURCE_Link_TF_LoadingTips:String = "TF_LoadingTips";
      
      public static const RESOURCE_Link_MC_Effect:String = "MC_Effect";
      
      public static const RESOURCE_Link_MC_LoadingSmallPanel:String = "MC_LoadingSmallPanel";
      
      public static const STRING_LoadingTips:Vector.<String> = Vector.<String>(["Cuanto más alto sea el nivel VIP, mejor beneficios serán!","Bestia convocada le dará atributos adicionales en Arena y los eventos!","Ninjutsu y Taijutsu van a hacer daño físico a los enemigos,sin embargo Genjutsu hace daño estratígico!","Atacar en Arena y recibir Tesoro de Arena para aumentar Reputación!","Equipamientos fuertes y talismanes buenos son claves para conseguir éxito!","Compra Jades adecuados aumentará enormemente puntos de fuerza!","La formación es la clave!","Cambia otra habilidad puede que cambie todo","Cuanto más alto sea el rango ninja, más compañeros de equipo te puede llevar a la batalla!","En el Reino caen Talismanes."]);
      
      protected var FLoader:Loader;
      
      protected var FXMLLoader:URLLoader;
      
      protected var FMC_Loading:Sprite;
      
      protected var FMC_Head:Sprite;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_ProgressBigBar02:MovieClip;
      
      protected var FMC_ProgressBigBar:Sprite;
      
      protected var FMC_ProgressSmallBar:Sprite;
      
      protected var FTF_ProgressBig:TextField;
      
      protected var FTF_ProgressSmall:TextField;
      
      protected var FMC_Fading:MovieClip;
      
      protected var FMC_LoadingSmallPanel:Sprite;
      
      protected var FTF_LoadingTips:TextField;
      
      protected var FOnLoadingCompleted:Function;
      
      public function TProcessorMiniLoad()
      {
         super();
         this.FMC_Loading = new MC_Loading();
         this.addChild(this.FMC_Loading);
         this.ResourcesPerform_UIDispatch();
         this.LoadResourceXml();
      }
      
      protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Sprite = null;
         this.FMC_Loading.x = (STAGE_Width - this.FMC_Loading.width) / 2 + 150;
         this.FMC_Loading.y = (STAGE_Height - this.FMC_Loading.height) / 2 + 260;
         this.FMC_Head = this.FMC_Loading[RESOURCE_Link_MC_Head];
         this.FMC_Effect = this.FMC_Loading[RESOURCE_Link_MC_Effect];
         this.FTF_ProgressBig = this.FMC_Loading[RESOURCE_Link_TF_ProgressBig];
         _loc1_ = this.FMC_Loading[RESOURCE_Link_MC_ProgressBigBar01];
         this.FMC_ProgressBigBar02 = _loc1_[RESOURCE_Link_MC_ProgressBigBar02];
         this.FMC_ProgressBigBar = this.FMC_ProgressBigBar02[RESOURCE_Link_MC_ProgressBigBar];
         this.FMC_ProgressBigBar.x = -this.FMC_ProgressBigBar.width;
         this.FTF_ProgressBig.text = "0%";
         this.FMC_LoadingSmallPanel = this.FMC_Loading[RESOURCE_Link_MC_LoadingSmallPanel];
         this.FMC_Fading = this.FMC_LoadingSmallPanel[RESOURCE_Link_MC_Fading];
         this.FTF_ProgressSmall = this.FMC_LoadingSmallPanel[RESOURCE_Link_TF_ProgressSmall];
         _loc2_ = this.FMC_LoadingSmallPanel[RESOURCE_Link_MC_ProgressSmallBar01];
         this.FTF_LoadingTips = this.FMC_LoadingSmallPanel[RESOURCE_Link_TF_LoadingTips];
         this.FMC_ProgressSmallBar = _loc2_[RESOURCE_Link_MC_ProgressSmallBar];
         this.FTF_ProgressSmall.text = "Iniciando el juego, por favor espere";
         this.FTF_LoadingTips.text = STRING_LoadingTips[TUtilityMath.RandomRange(0,STRING_LoadingTips.length - 1)];
         this.FMC_ProgressSmallBar.visible = false;
         this.FMC_Head.visible = false;
         this.PlayEffects();
      }
      
      protected function LoadResourceXml() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         this.FXMLLoader = new URLLoader();
         this.FXMLLoader.addEventListener(Event.COMPLETE,this.XMLLoadOnCompleted);
         this.FXMLLoader.addEventListener(IOErrorEvent.IO_ERROR,this.XMLLoadOnError);
         _loc2_ = this.GetClientVersion();
         if(_loc2_.length > 0)
         {
            _loc1_ = SParametersCore.CdnRoot + _loc2_ + "/" + STRING_LoadXMLUrl + "_" + _loc2_ + ".xml";
         }
         else
         {
            _loc1_ = SParametersCore.CdnRoot + STRING_LoadXMLUrl + ".xml";
         }
         this.FXMLLoader.load(new URLRequest(_loc1_));
      }
      
      protected function LoadMain() : void
      {
         var _loc1_:String = null;
         var _loc2_:Dictionary = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _loc1_ = "";
         this.FLoader = new Loader();
         this.FLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.LoadOnCompleted);
         this.FLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.LoadOnError);
         this.FLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.LoadOnProgress);
         _loc2_ = SParametersCore.ResourceVersionConfig;
         if(_loc2_)
         {
            _loc3_ = _loc2_[STRING_LoadMainUrl];
            if(Boolean(_loc3_) && _loc3_.length > 0)
            {
               _loc1_ = _loc2_[STRING_LoadMainUrl] + "/" + STRING_LoadMainUrl;
            }
            else
            {
               _loc4_ = this.GetClientVersion();
               _loc1_ = _loc4_ + "/" + STRING_LoadMainUrl;
            }
         }
         _loc1_ = SParametersCore.CdnRoot + _loc1_;
         this.FLoader.load(new URLRequest(_loc1_),new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      protected function GetClientVersion() : String
      {
         var _loc1_:String = null;
         return SParametersCore.ClientVersion.toString();
      }
      
      protected function PlayEffects(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.FMC_Effect.play();
            this.FMC_ProgressBigBar02.play();
            this.FMC_Fading.play();
         }
         else
         {
            this.FMC_Effect.stop();
            this.FMC_ProgressBigBar02.stop();
            this.FMC_Fading.stop();
         }
      }
      
      protected function XMLRemoveEventListeners() : void
      {
         if(this.FXMLLoader != null)
         {
            this.FXMLLoader.removeEventListener(Event.COMPLETE,this.XMLLoadOnCompleted);
            this.FXMLLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.XMLLoadOnError);
         }
      }
      
      protected function RemoveEventListeners() : void
      {
         if(this.FLoader != null)
         {
            this.FLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.LoadOnCompleted);
            this.FLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.LoadOnError);
            this.FLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.LoadOnProgress);
         }
      }
      
      protected function SetResource(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:XML = null;
         var _loc4_:XMLList = null;
         var _loc5_:XML = null;
         var _loc6_:Dictionary = null;
         var _loc7_:Dictionary = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         _loc6_ = new Dictionary();
         _loc7_ = new Dictionary();
         _loc3_ = new XML(param1);
         _loc4_ = _loc3_.Data;
         for(_loc2_ in _loc4_)
         {
            _loc5_ = _loc4_[_loc2_];
            _loc8_ = _loc5_.elements("key");
            _loc9_ = _loc5_.elements("version");
            _loc10_ = _loc5_.elements("size");
            _loc6_[_loc8_] = _loc9_;
            _loc7_[_loc8_] = _loc10_;
         }
         SParametersCore.CoerceResourceConfig(_loc6_,_loc7_);
      }
      
      protected function XMLLoadOnCompleted(param1:Event) : void
      {
         this.XMLRemoveEventListeners();
         this.SetResource(param1.target.data);
         this.LoadMain();
      }
      
      protected function XMLLoadOnError(param1:IOErrorEvent) : void
      {
         this.FTF_ProgressSmall.text = "游戏初始化失败！";
         this.XMLRemoveEventListeners();
      }
      
      protected function LoadOnCompleted(param1:Event) : void
      {
         this.RemoveEventListeners();
         if(this.FOnLoadingCompleted != null)
         {
            this.FOnLoadingCompleted(this,this.FLoader.contentLoaderInfo.content);
         }
      }
      
      protected function LoadOnError(param1:IOErrorEvent) : void
      {
         this.FTF_ProgressSmall.text = "游戏初始化失败！";
         this.RemoveEventListeners();
      }
      
      protected function LoadOnProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = 20 + Math.floor(param1.bytesLoaded * 80 / param1.bytesTotal);
         this.FTF_ProgressBig.text = Math.ceil(_loc2_).toString() + "%";
         this.FMC_ProgressBigBar.x = (100 - _loc2_) * (this.FMC_ProgressBigBar.width / 100) * -1;
      }
      
      public function get OnLoadingCompleted() : Function
      {
         return this.FOnLoadingCompleted;
      }
      
      public function set OnLoadingCompleted(param1:Function) : void
      {
         this.FOnLoadingCompleted = param1;
      }
      
      public function Dispose() : void
      {
         this.FLoader.unload();
         this.FLoader = null;
         this.PlayEffects(false);
         if(this.FMC_Loading.parent != null)
         {
            this.FMC_Loading.parent.removeChild(this.FMC_Loading);
         }
         this.FMC_Head = null;
         this.FMC_Effect = null;
         this.FMC_ProgressBigBar02 = null;
         this.FMC_ProgressBigBar = null;
         this.FMC_ProgressSmallBar = null;
         this.FTF_ProgressBig = null;
         this.FTF_ProgressSmall = null;
         this.FMC_Fading = null;
         this.FMC_LoadingSmallPanel = null;
         this.FTF_LoadingTips = null;
         this.FMC_Loading = null;
      }
   }
}

