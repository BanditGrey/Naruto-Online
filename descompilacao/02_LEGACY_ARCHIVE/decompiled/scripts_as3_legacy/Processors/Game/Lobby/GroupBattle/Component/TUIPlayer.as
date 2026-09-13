package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.UI.TUIComponent;
   import Logics.GroupBattle.TShadowPlayer;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIPlayer extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FMC_Option:MovieClip;
      
      protected var FChooseOnClick:Function;
      
      public function TUIPlayer(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Name = Resource["TF_Name"];
         this.FTF_Level = Resource["TF_Level"];
         this.FMC_Option = Resource["MC_Option"];
      }
      
      override protected function UILocations() : void
      {
         this.FMC_Option.addEventListener(MouseEvent.CLICK,this.MCOptionOnClick,false,0,true);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TShadowPlayer = null;
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TShadowPlayer;
         this.FTF_Name.text = _loc1_.PlayerName;
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.PlayerLevel);
         this.FMC_Option.gotoAndStop((_loc1_.AuthorizeStatus + 1) % 2 + 1);
      }
      
      protected function MCOptionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TShadowPlayer = null;
         _loc3_ = Context as TShadowPlayer;
         _loc2_ = uint(this.FMC_Option.currentFrame);
         if(this.FChooseOnClick != null)
         {
            this.FChooseOnClick(this,_loc3_.Identifier0,_loc3_.Identifier1,_loc2_ - 1);
         }
      }
      
      public function set ChooseOnClick(param1:Function) : void
      {
         this.FChooseOnClick = param1;
      }
   }
}

