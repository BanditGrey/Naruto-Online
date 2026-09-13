package Processors.Game.Lobby.Exercise.CreationAncestor
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.CreationAncestor.TCreationAncestor;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUICreationAncestor1 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected var FCreationAncestor:TCreationAncestor;
      
      public function TUICreationAncestor1(param1:TUIComponent)
      {
         super(param1);
         this.FCreationAncestor = SLogicsCore.CreationAncestor;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT + 1)
         {
            param1 = FMC_Scene["MC_Box" + _loc2_];
            TGameUtil.setButtonMode(param1.MC_Icon,true);
            param1.MC_Icon.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxClick);
            param1.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            param1.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Effect.mouseEnabled = false;
         FMC_Scene.MC_Effect.mouseChildren = false;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FCreationAncestor.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FCreationAncestor.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FCreationAncestor.DescListNew[1];
         FMC_Scene.TF_RechargeGold.text = this.FCreationAncestor.TotalRechargeGold.toString();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc2_ = this.FCreationAncestor.BoxList[_loc1_];
            _loc3_.TF_Price.text = _loc2_.Price.toString();
            _loc3_.TF_Point.text = _loc2_.Count.toString();
            if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               TGameUtil.setButtonMode(_loc3_.MC_Icon,false);
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_Click.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               TGameUtil.setButtonMode(_loc3_.MC_Icon,true);
               _loc3_.MC_Got.visible = false;
               _loc3_.MC_Click.visible = true;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               TGameUtil.setButtonMode(_loc3_.MC_Icon,false);
               _loc3_.MC_Icon.gotoAndStop(1);
               _loc3_.MC_Got.visible = true;
               _loc3_.MC_Click.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateServerBox() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:MovieClip = null;
         _loc2_ = FMC_Scene["MC_Box4"];
         _loc1_ = this.FCreationAncestor.ServerBox;
         FMC_Scene.TF_Total.text = _loc1_.Price.toString();
         FMC_Scene.TF_Last.text = _loc1_.CurPrice.toString();
         FMC_Scene.TF_Today.text = this.FCreationAncestor.Score.toString();
         if(_loc1_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            TGameUtil.setButtonMode(_loc2_.MC_Icon,false);
            _loc2_.MC_Got.visible = false;
            _loc2_.MC_Click.visible = false;
         }
         else if(_loc1_.Status == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(_loc2_.MC_Icon,true);
            _loc2_.MC_Got.visible = false;
            FMC_Scene.MC_Effect.gotoAndPlay(1);
            _loc2_.MC_Click.visible = true;
         }
         else if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            TGameUtil.setButtonMode(_loc2_.MC_Icon,false);
            _loc2_.MC_Icon.gotoAndStop(1);
            _loc2_.MC_Got.visible = true;
            _loc2_.MC_Click.visible = false;
         }
      }
      
      protected function ProcessorOnBoxClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc2_ == 4)
         {
            FOnGetBox(TProcessorCreationAncestor.GET_SERVER_BOX_REQ);
         }
         else
         {
            FOnGetBox(TProcessorCreationAncestor.GET_BOX_REQ,_loc2_ + 1);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc2_ == 4)
         {
            FOnNewBoxOver(this.FCreationAncestor.ServerBox.Inventories);
         }
         else
         {
            FOnNewBoxOver(this.FCreationAncestor.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(1);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && FMC_Scene.visible && this.Visible)
         {
            if(FIsPlaying)
            {
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateServerBox();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         FIsPlaying = true;
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
      
      override public function Unmount() : void
      {
      }
   }
}

