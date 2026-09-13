package Processors.Game.Lobby.WuXing
{
   import Foundation.Utilities.TGameUtil;
   import Logics.WuXing.TWuXing;
   import Resources.Constants.CONST_WUXING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIWuxingUint
   {
      
      protected var FContent:MovieClip;
      
      protected var Btn_Activate:MovieClip;
      
      protected var MC_Ele:MovieClip;
      
      protected var FIndex:int;
      
      protected var FHeroId:int;
      
      public var OnClickFunc:Function;
      
      public const ELE_TYPE:Array = CONST_WUXING.ELE_TYPE;
      
      public function TUIWuxingUint(param1:MovieClip, param2:int)
      {
         super();
         this.FContent = param1;
         this.FIndex = param2;
         this.init();
      }
      
      protected function init() : void
      {
         var _loc1_:String = this.ELE_TYPE[this.FIndex];
         this.MC_Ele = this.FContent["ele_" + _loc1_];
         this.Btn_Activate = this.FContent["Btn_" + _loc1_];
         this.Btn_Activate.addEventListener(MouseEvent.CLICK,this.OnActivateClick);
         this.Btn_Activate.buttonMode = true;
      }
      
      public function upWuxingInfo(param1:TWuXing) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = param1.ElementBit >> this.FIndex & 1;
            this.FHeroId = param1.heroId;
            if(_loc2_ == 1)
            {
               this.Btn_Activate.visible = false;
               this.MC_Ele.filters = [];
            }
            else
            {
               this.MC_Ele.filters = [TGameUtil.GaryColorFilters];
               this.Btn_Activate.visible = true;
               if(param1.ElementPoint == 0)
               {
                  this.Btn_Activate.visible = false;
               }
            }
         }
      }
      
      protected function OnActivateClick(param1:MouseEvent) : void
      {
         if(this.OnClickFunc != null && this.FHeroId != 0)
         {
            this.OnClickFunc(this.FHeroId,this.FIndex);
         }
      }
   }
}

