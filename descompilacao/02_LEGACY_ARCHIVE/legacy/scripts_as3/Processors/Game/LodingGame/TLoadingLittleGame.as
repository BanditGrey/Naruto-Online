package Processors.Game.LodingGame
{
   import Foundation.UI.TUIComponent;
   import Logics.Agent.SParametersCore;
   import Processors.Game.TProcessorGame;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class TLoadingLittleGame extends TProcessorGame
   {
      
      protected static const CONST_URL:String = "Resources/Swf/Lobby/";
      
      protected static const CONST_ResourceID:String = "1B000000";
      
      protected var FLoader:Loader;
      
      protected var FResourceConfig:Dictionary;
      
      protected var GameClassDefinition:Object;
      
      public function TLoadingLittleGame(param1:TUIComponent)
      {
         super(param1);
         this.FLoader = new Loader();
         this.FLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.LoadComplet);
         this.FResourceConfig = SParametersCore.ResourceVersionConfig;
      }
      
      protected function LoadComplet(param1:Event) : void
      {
         this.FLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.LoadComplet);
         this.GameClassDefinition = param1.currentTarget;
         addChild(this.GameClassDefinition.content);
         this.x = (FUICore.StageWidth - this.width) / 2;
         this.y = (FUICore.StageHeight - this.height) / 2 - 15;
      }
      
      public function UnloadLoadingGame() : void
      {
         this.GameClassDefinition.content["CloseExecute"]();
         this.GameClassDefinition = null;
         this.FLoader.unloadAndStop();
         this.FLoader = null;
      }
      
      public function LoadResources() : void
      {
         this.FLoader.load(new URLRequest(this.GetUrl()));
      }
      
      protected function GetUrl() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         _loc1_ = CONST_URL + CONST_ResourceID + ".swf";
         if(this.FResourceConfig)
         {
            _loc2_ = this.FResourceConfig[_loc1_];
         }
         if(_loc2_ == null)
         {
            if(SParametersCore.ClientVersion == 0)
            {
               _loc2_ = "";
            }
            else
            {
               _loc2_ = SParametersCore.ClientVersion.toString();
            }
         }
         if(_loc2_.length > 0)
         {
            _loc1_ = _loc2_ + "/" + _loc1_;
         }
         return SParametersCore.CdnRoot + _loc1_;
      }
   }
}

