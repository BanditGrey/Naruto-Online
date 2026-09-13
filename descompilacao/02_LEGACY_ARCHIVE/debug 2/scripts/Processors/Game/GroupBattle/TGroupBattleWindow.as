package Processors.Game.GroupBattle
{
   import Externals.SExternalCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TGroupBattleWindow extends TUIComponent
   {
      
      protected static const MAX_PLAYER_COUNT:uint = 3;
      
      protected static const MAX_ENEMY_COUNT:uint = 6;
      
      protected static const MAX_REPORT_COUNT:uint = 5;
      
      protected var FScene:MovieClip;
      
      protected var FBattleScene:MovieClip;
      
      protected var FBattleBackgroud:Sprite;
      
      protected var FPlayerHeadBitmap:Vector.<Bitmap>;
      
      protected var FPlayerStatusMC:Vector.<MovieClip>;
      
      protected var FEnemyHeadBitmap:Vector.<Bitmap>;
      
      protected var FEnemyStatusMC:Vector.<MovieClip>;
      
      protected var FReportTextField:Vector.<TextField>;
      
      protected var FReportButton:Vector.<MovieClip>;
      
      protected var FBackGroundBitmap:Bitmap;
      
      protected var FPlayerHeadId:Vector.<uint>;
      
      protected var FPlayerStatus:Vector.<uint>;
      
      protected var FEnemyHeadId:Vector.<uint>;
      
      protected var FEnemyStatus:Vector.<uint>;
      
      protected var FReportInfoVect:Vector.<String>;
      
      protected var FReportIdVect:Vector.<String>;
      
      protected var FHeadUIWidth:uint;
      
      protected var FReportUIWidth:uint;
      
      protected var FReportUIX:uint;
      
      protected var FBackGroundId:uint;
      
      protected var FOnSkipBattle:Function;
      
      public function TGroupBattleWindow(param1:TUIComponent)
      {
         super(param1);
         this.FPlayerHeadBitmap = new Vector.<Bitmap>(MAX_PLAYER_COUNT);
         this.FPlayerStatusMC = new Vector.<MovieClip>(MAX_PLAYER_COUNT);
         this.FEnemyHeadBitmap = new Vector.<Bitmap>(MAX_ENEMY_COUNT);
         this.FEnemyStatusMC = new Vector.<MovieClip>(MAX_ENEMY_COUNT);
         this.FReportTextField = new Vector.<TextField>(MAX_REPORT_COUNT);
         this.FReportButton = new Vector.<MovieClip>(MAX_REPORT_COUNT);
         this.FPlayerHeadId = new Vector.<uint>(MAX_PLAYER_COUNT);
         this.FPlayerStatus = new Vector.<uint>(MAX_PLAYER_COUNT);
         this.FEnemyHeadId = new Vector.<uint>(MAX_ENEMY_COUNT);
         this.FEnemyStatus = new Vector.<uint>(MAX_ENEMY_COUNT);
         this.FReportInfoVect = new Vector.<String>();
         this.FReportIdVect = new Vector.<String>();
      }
      
      protected function InitWindow() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Bitmap = null;
         this.FHeadUIWidth = this.FScene["MC_Player0"].width + 3;
         this.FReportUIWidth = this.FScene["MC_Report"].width;
         this.FReportUIX = this.FScene["MC_Report"].x;
         _loc1_ = 0;
         while(_loc1_ < MAX_PLAYER_COUNT)
         {
            _loc3_ = new Bitmap();
            this.FPlayerHeadBitmap[_loc1_] = _loc3_;
            this.FScene["MC_Player" + _loc1_]["MC_Head"]["MC_Head"].addChild(_loc3_);
            this.FPlayerStatusMC[_loc1_] = this.FScene["MC_Player" + _loc1_]["MC_Status"];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_ENEMY_COUNT)
         {
            _loc3_ = new Bitmap();
            this.FEnemyHeadBitmap[_loc1_] = _loc3_;
            this.FScene["MC_Enemy" + _loc1_]["MC_Head"]["MC_Head"].addChild(_loc3_);
            this.FEnemyStatusMC[_loc1_] = this.FScene["MC_Enemy" + _loc1_]["MC_Status"];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_REPORT_COUNT)
         {
            this.FReportTextField[_loc1_] = this.FScene["MC_Report"]["TF_FightReport_" + _loc1_];
            this.FReportButton[_loc1_] = this.FScene["MC_Report"]["BTN_FightReport_" + _loc1_];
            TGameUtil.setButtonMode(this.FReportButton[_loc1_],true);
            this.FReportButton[_loc1_].addEventListener(MouseEvent.CLICK,this.OnReportView);
            this.FReportTextField[_loc1_].visible = false;
            this.FReportButton[_loc1_].visible = false;
            _loc1_++;
         }
         TGameUtil.setButtonMode(this.FScene["BTN_Skip"],true);
         this.FScene["BTN_Skip"].addEventListener(MouseEvent.CLICK,this.OnSkipGroupBattle);
         this.FScene["BTN_Skip"].y = FUICore.StageHeight - this.FScene["BTN_Skip"].height - 15;
         this.FBackGroundBitmap = new Bitmap();
         addChild(this.FBackGroundBitmap);
         this.UpdataResize();
      }
      
      protected function UpdataPlayerStatus() : void
      {
         var _loc1_:uint = 0;
         if(this.FScene == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_PLAYER_COUNT)
         {
            this.FPlayerStatusMC[_loc1_].gotoAndStop(this.FPlayerStatus[_loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_ENEMY_COUNT)
         {
            this.FEnemyStatusMC[_loc1_].gotoAndStop(this.FEnemyStatus[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function MakeReportInfo(param1:String, param2:String, param3:uint) : String
      {
         return TUtilityString.Format(STRING_GROUPBATTLE.STRING_REPORT,param1,param2,param3 ? param2 : param1);
      }
      
      protected function UpdataResize() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this.FScene == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_PLAYER_COUNT)
         {
            this.FScene["MC_Player" + _loc1_].x = this.FReportUIX - (_loc1_ + 1) * this.FHeadUIWidth;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_ENEMY_COUNT)
         {
            this.FScene["MC_Enemy" + _loc1_].x = this.FReportUIX + this.FReportUIWidth + 3 + _loc1_ * this.FHeadUIWidth;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_PLAYER_COUNT)
         {
            _loc3_ = this.FPlayerHeadId[_loc1_];
            if(_loc3_ == 0)
            {
               _loc2_ = _loc1_ + 1;
               while(_loc2_ < MAX_PLAYER_COUNT)
               {
                  this.FScene["MC_Player" + _loc2_].x += this.FHeadUIWidth;
                  _loc2_++;
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_ENEMY_COUNT)
         {
            _loc3_ = this.FEnemyHeadId[_loc1_];
            if(_loc3_ == 0)
            {
               _loc2_ = _loc1_ + 1;
               while(_loc2_ < MAX_PLAYER_COUNT)
               {
                  this.FScene["MC_Enemy" + _loc2_].x -= this.FHeadUIWidth;
                  _loc2_++;
               }
            }
            _loc1_++;
         }
      }
      
      protected function OnSkipGroupBattle(param1:MouseEvent) : void
      {
         if(this.FOnSkipBattle != null)
         {
            this.FOnSkipBattle(this);
         }
      }
      
      protected function OnReportView(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(int(String(param1.target.name).slice(16)));
         SExternalCore.NavigateToFightReport(this.FReportIdVect[Math.max(this.FReportIdVect.length - MAX_REPORT_COUNT,0) + _loc2_]);
      }
      
      public function get OnSkipBattle() : Function
      {
         return this.FOnSkipBattle;
      }
      
      public function set OnSkipBattle(param1:Function) : void
      {
         this.FOnSkipBattle = param1;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FScene = param1;
         this.InitWindow();
         this.UpdataPlayerStatus();
      }
      
      public function Reset() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         this.FReportInfoVect.length = 0;
         this.FReportIdVect.length = 0;
         _loc2_ = this.FPlayerStatus.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FPlayerStatus[_loc1_] = CONST_GROUPBATTLE.FightStatus_Waiting;
            _loc1_++;
         }
         _loc2_ = this.FEnemyStatus.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FEnemyStatus[_loc1_] = CONST_GROUPBATTLE.FightStatus_Waiting;
            _loc1_++;
         }
         this.UpdataReport();
      }
      
      public function SetPlayerHead(param1:Vector.<uint>, param2:Vector.<uint>, param3:uint) : void
      {
         this.FPlayerHeadId = param1;
         this.FEnemyHeadId = param2;
         this.FBackGroundId = param3;
         this.UpdataResize();
      }
      
      public function SetPlayerStatus(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this.FPlayerStatus[param1] = param2;
         this.FEnemyStatus[param3] = param4;
         this.UpdataPlayerStatus();
         if(this.FScene)
         {
            this.FScene["BTN_Skip"].y = FUICore.StageHeight - this.FScene["BTN_Skip"].height - 15;
         }
      }
      
      public function UpdataPlayerHead() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(this.FScene == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_PLAYER_COUNT)
         {
            _loc2_ = this.FPlayerHeadId[_loc1_];
            if(_loc2_ != 0)
            {
               this.FScene["MC_Player" + _loc1_].visible = true;
               TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FPlayerHeadBitmap[_loc1_],CONST_MODULES.MODULE_GroupBattle,_loc2_);
            }
            else
            {
               this.FScene["MC_Player" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_ENEMY_COUNT)
         {
            _loc2_ = this.FEnemyHeadId[_loc1_];
            if(_loc2_ != 0)
            {
               this.FScene["MC_Enemy" + _loc1_].visible = true;
               TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FEnemyHeadBitmap[_loc1_],CONST_MODULES.MODULE_GroupBattle,_loc2_);
            }
            else
            {
               this.FScene["MC_Enemy" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBackGroundBitmap,CONST_MODULES.MODULE_GroupBattle,this.FBackGroundId);
      }
      
      public function AddFightReport(param1:String, param2:String, param3:uint, param4:String) : void
      {
         var _loc5_:String = null;
         _loc5_ = this.MakeReportInfo("<font color=\'#66FF33\'>" + param1 + "</font>","<font color=\'#FF0000\'>" + param2 + "</font>",param3);
         this.FReportInfoVect.push(_loc5_);
         this.FReportIdVect.push(param4);
         this.UpdataReport();
      }
      
      public function UpdataReport() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this.FScene == null)
         {
            return;
         }
         _loc3_ = Math.max(this.FReportIdVect.length - MAX_REPORT_COUNT,0);
         _loc1_ = 0;
         while(_loc1_ < MAX_REPORT_COUNT)
         {
            if(_loc3_ + _loc1_ < this.FReportInfoVect.length)
            {
               this.FReportTextField[_loc1_].visible = true;
               this.FReportButton[_loc1_].visible = true;
               this.FReportTextField[_loc1_].htmlText = this.FReportInfoVect[_loc3_ + _loc1_];
            }
            else
            {
               this.FReportTextField[_loc1_].visible = false;
               this.FReportButton[_loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public function UnLoadBackGround() : void
      {
         if(this.FBackGroundBitmap.bitmapData != null)
         {
            this.FBackGroundBitmap.bitmapData = null;
         }
      }
   }
}

