package Processors.Game.Lobby.LostShenqi.Panel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Strings.STRING_LOSTSHENQI;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorLostMi extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FMC_EnterMaze:MovieClip;
      
      protected var FMC_BuyBtn:MovieClip;
      
      protected var FTF_Count:TextField;
      
      protected var FTF_GameState:TextField;
      
      protected var FTF_LostJadeCount:TextField;
      
      protected var FEnterInMiGongFunction:Function;
      
      protected var FBuyFunction:Function;
      
      public function TProcessorLostMi(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set SetPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.IniLization();
      }
      
      protected function IniLization() : void
      {
         this.FMC_EnterMaze = this.FThisPanel["MC_EnterMaze"];
         this.FMC_BuyBtn = this.FThisPanel["MC_BuyBtn"];
         this.FTF_Count = this.FThisPanel["TF_Count"];
         this.FTF_GameState = this.FThisPanel["TF_GameState"];
         this.FTF_LostJadeCount = this.FThisPanel["TF_LostJadeCount"];
      }
      
      public function OpenThisPanel() : void
      {
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         _loc1_ = int(SLogicsCore.LostShenQiLogicData.CurGameState);
         _loc3_ = int(SLogicsCore.LostShenQiLogicData.MiGongShenYuCiShu);
         this.FTF_Count.text = _loc3_.toString();
         this.FTF_LostJadeCount.text = SLogicsCore.LostShenQiLogicData.LostJadeNum.toString();
         if(SLogicsCore.LostShenQiLogicData.VipCanRestCount > SLogicsCore.LostShenQiLogicData.YiJingChongZhiCishu)
         {
            if(!_loc1_ && _loc3_ > 0)
            {
               _loc2_ = false;
            }
            else
            {
               _loc2_ = true;
            }
         }
         else if(Boolean(_loc1_) && _loc3_ > 0)
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = false;
         }
         TGameUtil.setButtonMode(this.FMC_BuyBtn,_loc2_);
         if(SLogicsCore.LostShenQiLogicData.MiGongShenYuCiShu > 0 || Boolean(_loc1_))
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = false;
         }
         TGameUtil.setButtonMode(this.FMC_EnterMaze,_loc2_);
         if(_loc1_)
         {
            this.FTF_GameState.text = STRING_LOSTSHENQI.str12;
            this.FTF_GameState.textColor = 52224;
         }
         else
         {
            this.FTF_GameState.text = STRING_LOSTSHENQI.str13;
            this.FTF_GameState.textColor = 16711680;
         }
      }
      
      public function UiLocations() : void
      {
         this.FMC_EnterMaze.addEventListener(MouseEvent.CLICK,this.HandleCilck);
         this.FMC_BuyBtn.addEventListener(MouseEvent.CLICK,this.HandleCilck);
      }
      
      protected function HandleCilck(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_EnterMaze:
               if(!this.FMC_EnterMaze.buttonMode)
               {
                  return;
               }
               if(this.FEnterInMiGongFunction != null)
               {
                  this.FEnterInMiGongFunction();
               }
               break;
            case this.FMC_BuyBtn:
               if(!this.FMC_BuyBtn.buttonMode)
               {
                  return;
               }
               if(this.FBuyFunction != null)
               {
                  this.FBuyFunction();
               }
         }
      }
      
      public function LogicsUpdate() : void
      {
      }
      
      public function set EnterInMiGongFunction(param1:Function) : void
      {
         this.FEnterInMiGongFunction = param1;
      }
      
      public function set BuyFunction(param1:Function) : void
      {
         this.FBuyFunction = param1;
      }
   }
}

