package Processors.Game.Lobby.RebirthRealm
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowDestinyCoronaPanel extends TProcessorLobbyWindow
   {
      
      public static const Seven:int = 8;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var FRootPanel:MovieClip;
      
      protected var FRebirthRealmBaseData:TRebirthRealmBaseData = null;
      
      protected var FMvcModuleVec:Vector.<MovieClip>;
      
      protected var FMvcPropertyVec:Vector.<MovieClip>;
      
      protected var FTF_Property:TextField;
      
      protected var FPointerTurntable:TPointerTurntable = null;
      
      protected var FMC_BackGround:MovieClip = null;
      
      protected var Fmc_gameLoseMovie:MovieClip = null;
      
      protected var FChallengeBtn:SimpleButton = null;
      
      protected var FBeginFun:Function;
      
      protected var FEndFun:Function;
      
      protected var FTurntableTipMove:Function;
      
      protected var FTurntableTipOut:Function;
      
      protected var FTurnEndIndex:int;
      
      public function TProcessorWindowDestinyCoronaPanel(param1:TUIComponent, param2:TRebirthRealmBaseData)
      {
         super(param1);
         this.FRebirthRealmBaseData = param2;
         this.FMvcModuleVec = new Vector.<MovieClip>(Seven);
         this.FMvcPropertyVec = new Vector.<MovieClip>(Seven);
         this.FPointerTurntable = new TPointerTurntable();
         this.FPointerTurntable.EndFunction = this.EndFunF;
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         this.FRootPanel = param1;
         _loc2_ = 0;
         while(_loc2_ < Seven)
         {
            this.FMvcModuleVec[_loc2_] = this.FRootPanel["MC_Module_" + _loc2_];
            this.FMvcPropertyVec[_loc2_] = this.FRootPanel["MC_Property_" + _loc2_];
            _loc2_++;
         }
         this.FChallengeBtn = this.FRootPanel["MC_Turntable_Start_Btn"];
         this.FPointerTurntable.SetBaseMovieClip(this.FMvcModuleVec);
         this.FMC_BackGround = this.FRootPanel["MC_BackGround"];
         this.Fmc_gameLoseMovie = this.FRootPanel["mc_gameLoseMovie"];
         this.FTF_Property = this.Fmc_gameLoseMovie["MC_GetProperty"]["TF_GetProperty"];
         this.Fmc_gameLoseMovie.visible = false;
         this.FPointerTurntable.Reset();
         this.FChallengeBtn.addEventListener(MouseEvent.CLICK,this.BeginClick);
         this.FChallengeBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.TurntableTipMoveF);
         this.FChallengeBtn.addEventListener(MouseEvent.MOUSE_OUT,this.TurntableTipOutF);
      }
      
      public function set TurntableTipMove(param1:Function) : void
      {
         this.FTurntableTipMove = param1;
      }
      
      public function set TurntableTipOut(param1:Function) : void
      {
         this.FTurntableTipOut = param1;
      }
      
      protected function TurntableTipMoveF(param1:MouseEvent) : void
      {
         if(this.FTurntableTipMove != null)
         {
            this.FTurntableTipMove();
         }
      }
      
      protected function TurntableTipOutF(param1:MouseEvent) : void
      {
         if(this.FTurntableTipOut != null)
         {
            this.FTurntableTipOut();
         }
      }
      
      public function UpdateManual() : void
      {
         var _loc1_:int = 0;
         this.FMC_BackGround.gotoAndPlay(1);
         this.Valuation();
      }
      
      public function Valuation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         _loc1_ = 0;
         while(_loc1_ < this.FRebirthRealmBaseData.AddAttributeVec2_Obj.length)
         {
            _loc2_ = Object(this.FRebirthRealmBaseData.AddAttributeVec2_Obj[_loc1_]);
            TextField(this.FMvcPropertyVec[_loc1_]["MC_Property"]["TF_Property"]).text = STRINGS_BASEATTRIBUTENAMES[BASEATTRIBUTENAMES.indexOf(_loc2_.type)] + "\n" + this.getString(_loc2_.num);
            _loc1_++;
         }
      }
      
      public function getString(param1:Number) : String
      {
         var _loc2_:String = "+";
         if(param1 < 1)
         {
            _loc2_ = _loc2_ + Number(param1 * 100).toFixed(1) + "%";
         }
         else
         {
            _loc2_ += int(param1);
         }
         return _loc2_;
      }
      
      public function ClosePanel() : void
      {
         this.FMC_BackGround.gotoAndStop(1);
      }
      
      public function UpdatePerform() : void
      {
         this.FPointerTurntable.LogicsPerform();
      }
      
      public function BeginClick(param1:MouseEvent) : void
      {
         if(this.FBeginFun != null)
         {
            this.FBeginFun();
         }
      }
      
      public function PointerTurntableStart(param1:int) : void
      {
         this.FPointerTurntable.SetStart(param1);
         this.FTurnEndIndex = param1;
      }
      
      public function EndFunF(param1:int) : void
      {
         this.FMvcPropertyVec[this.FTurnEndIndex].gotoAndPlay(1);
         this.FTF_Property.text = TUtilityString.Format(STRING_COMMON.SixFary_GetProperty,STRINGS_BASEATTRIBUTENAMES[BASEATTRIBUTENAMES.indexOf(this.FRebirthRealmBaseData.AttribType)],this.getString(this.FRebirthRealmBaseData.AttribNum));
         this.Fmc_gameLoseMovie.visible = true;
         this.Fmc_gameLoseMovie.gotoAndPlay(1);
         if(this.FEndFun != null)
         {
            this.FEndFun();
         }
      }
      
      public function set BeginFun(param1:Function) : void
      {
         this.FBeginFun = param1;
      }
      
      public function set EndFun(param1:Function) : void
      {
         this.FEndFun = param1;
      }
   }
}

