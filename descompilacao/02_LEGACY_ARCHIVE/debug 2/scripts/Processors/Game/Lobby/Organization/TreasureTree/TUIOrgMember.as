package Processors.Game.Lobby.Organization.TreasureTree
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Organization.TreasureTree.TUserWaterInfo;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIOrgMember extends TProcessorUIResourceTemplate
   {
      
      protected var FMC_Water:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FMC_CDTime:Sprite;
      
      protected var FTF_CDTime:TextField;
      
      protected var FWaterOnClick:Function;
      
      public function TUIOrgMember(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         if(FResource == null)
         {
            return;
         }
         this.FMC_Water = FResource["MC_Water"];
         this.FTF_Name = FResource["TF_Name"];
         this.FMC_CDTime = FResource["MC_CDTime"];
         this.FTF_CDTime = this.FMC_CDTime["TF_CDTime"];
         TGameUtil.setButtonMode(this.FMC_Water,true);
      }
      
      override protected function UILocations() : void
      {
         super.UILocations();
         this.FMC_Water.addEventListener(MouseEvent.CLICK,this.MCWaterOnClick,false,0,true);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TUserWaterInfo = null;
         var _loc2_:int = 0;
         if(FContext == null)
         {
            this.Reset();
            return;
         }
         _loc1_ = FContext as TUserWaterInfo;
         this.FTF_Name.text = _loc1_.OrgMemberName;
         _loc2_ = _loc1_.NextWaterTime - STimingCore.GetServerTick();
         this.FMC_CDTime.visible = _loc2_ >= 0;
         this.FMC_Water.visible = !this.FMC_CDTime.visible;
      }
      
      protected function MCWaterOnClick(param1:MouseEvent) : void
      {
         if(this.FWaterOnClick != null)
         {
            this.FWaterOnClick(this,FContext);
         }
      }
      
      public function set WaterOnClick(param1:Function) : void
      {
         this.FWaterOnClick = param1;
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FMC_Water.visible = false;
         this.FMC_CDTime.visible = false;
      }
      
      public function UpdateCDTime() : void
      {
         var _loc1_:TUserWaterInfo = null;
         var _loc2_:int = 0;
         if(!this.Parent.Visible || !this.Visible)
         {
            return;
         }
         if(FContext != null)
         {
            _loc1_ = FContext as TUserWaterInfo;
            _loc2_ = _loc1_.NextWaterTime - STimingCore.GetServerTick();
            if(_loc2_ >= 0)
            {
               this.FTF_CDTime.text = TGameUtil.fomatTime(_loc2_);
            }
            this.FMC_CDTime.visible = _loc2_ >= 0;
         }
      }
   }
}

