package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Rendering.Overlayers.TongLingAnimal.TongLingAttriteTip;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorPathPic extends TProcessorLobbyWindow
   {
      
      public static const CELLCOUNT:int = 20;
      
      public static var ISUPDATE:int = 0;
      
      protected var FRootPanel:MovieClip;
      
      protected var FTempCore:TUICore;
      
      protected var FPComPent:TUIComponent;
      
      protected var VecPath:Vector.<jinhuaPathcell> = new Vector.<jinhuaPathcell>();
      
      protected var FTipShop:TongLingAttriteTip;
      
      protected var FSprite:Sprite = new Sprite();
      
      public function TProcessorPathPic(param1:TUIComponent, param2:TUICore)
      {
         this.FPComPent = param1;
         this.FTempCore = param2;
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TONGLINGANIMAL.TONGLING_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      public function BeginDraw() : void
      {
         this.FSprite.graphics.beginFill(0,0.3);
         this.FSprite.graphics.drawRect(0,0,this.FTempCore.StageWidth,this.FTempCore.StageHeight);
         this.FSprite.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:jinhuaPathcell = null;
         var _loc3_:uint = 0;
         this.FRootPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TONGLINGANIMAL.Path_Road) as MovieClip;
         addChild(this.FSprite);
         this.BeginDraw();
         this.FSprite.addChild(this.FRootPanel);
         this.FSprite.x = this.FTempCore.StageWidth - this.FSprite.width >> 1;
         this.FSprite.y = this.FTempCore.StageHeight - this.FSprite.height >> 1;
         this.FRootPanel.x = this.FSprite.width - this.FRootPanel.width >> 1;
         this.FRootPanel.y = this.FSprite.height - this.FRootPanel.height >> 1;
         var _loc2_:int = 1;
         while(_loc2_ < CELLCOUNT)
         {
            _loc3_ = 100000;
            _loc3_ += _loc2_;
            _loc1_ = new jinhuaPathcell(this.FRootPanel["MC_Path_T_" + _loc2_]);
            _loc1_.SetCoent(_loc3_);
            _loc1_.OverFunction = this.OverFunction;
            _loc1_.OutFunction = this.OutFunction;
            _loc1_.MoveFunction = this.MoveFunction;
            this.VecPath.push(_loc1_);
            _loc2_++;
         }
         SimpleButton(this.FRootPanel["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.clickH);
         this.FTipShop = new TongLingAttriteTip(this.FPComPent);
         this.FTipShop.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTipShop);
         super.ResourcesPerform_UIDispatch();
      }
      
      public function clickH(param1:MouseEvent) : void
      {
         this.visible = false;
         ISUPDATE = 0;
      }
      
      public function OverFunction(param1:uint) : void
      {
         var _loc2_:Object = {
            "id":param1,
            "index":1,
            "level":1
         };
         this.FTipShop.Context = _loc2_;
         this.FTipShop.Render(this.FTempCore.MouseCoordinate);
         this.FTipShop.Show();
      }
      
      public function OutFunction(param1:uint) : void
      {
         this.FTipShop.Hide();
      }
      
      public function MoveFunction(param1:uint) : void
      {
         this.FTipShop.Render(this.FTempCore.MouseCoordinate);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      public function Updates() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.VecPath.length)
         {
            this.VecPath[_loc1_].update();
            _loc1_++;
         }
      }
   }
}

