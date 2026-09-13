package Processors.Game.Lobby.GroupBattle.Plate
{
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Campaign.TMonster;
   import Logics.Campaign.TMonsters;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TLeagueMapPve;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TMonsterInfo;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.GroupBattle.Component.TOverlayerMonster;
   import Processors.Game.Lobby.GroupBattle.Component.TOverlayerPlayer;
   import Processors.Game.Lobby.GroupBattle.Component.TUIPlayerHead;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowBattleReady extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_PLAYERHEADS:uint = 3;
      
      protected const CAPACITY_MONSTERHEADS:uint = 6;
      
      protected var FMC_StartBattle:MovieClip;
      
      protected var FTF_CountDown:TextField;
      
      protected var FUIPlayerHeads:Vector.<TUIPlayerHead>;
      
      protected var FUIMonsterHeads:Vector.<TUIHeroHead>;
      
      protected var FSelectHeroBitmap:Bitmap;
      
      protected var FSelectHeroDefault:MovieClip;
      
      protected var FShowHeroCoordinate:TCoordinate;
      
      protected var FRoleModel:TBins;
      
      protected var FHero:THero;
      
      protected var FHeroTag:int;
      
      protected var FOverlayerPlayer:TOverlayerPlayer;
      
      protected var FOverlayerMonster:TOverlayerMonster;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FPlayerActive:Vector.<TActive>;
      
      protected var FMonsterActive:Vector.<TActive>;
      
      protected var FBackGroundBitmap:Bitmap;
      
      protected var FBackGroundComponent:TUIComponent;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FIsAutoStart:Boolean;
      
      protected var FMapId:uint;
      
      protected var FStartBattleOnClick:Function;
      
      protected var FExchangePosition:Function;
      
      public function TProcessorWindowBattleReady(param1:TUIComponent)
      {
         super(param1);
         this.FUIPlayerHeads = new Vector.<TUIPlayerHead>(this.CAPACITY_PLAYERHEADS);
         this.FUIMonsterHeads = new Vector.<TUIHeroHead>(this.CAPACITY_MONSTERHEADS);
         this.FHeroTag = -1;
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActive = null;
         var _loc4_:TUIPlayerHead = null;
         var _loc5_:int = 0;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         _loc5_ = this.FEffDelayReferenceTick - STimingCore.GetServerTick();
         if(this.FTF_CountDown != null)
         {
            if(_loc5_ < 0)
            {
               return;
            }
            this.FTF_CountDown.text = STRING_GROUPBATTLE.STRING_StartBattle + "(" + _loc5_ + ")";
            if(this.FIsAutoStart)
            {
               if(_loc5_ <= 1)
               {
                  this.MCStartBattleOnClick(null);
                  this.FIsAutoStart = false;
               }
            }
         }
         this.CheckMouseIcon();
         if(this.FOverlayerPlayer.Visible)
         {
            this.FOverlayerPlayer.Update();
         }
         if(this.FOverlayerMonster.Visible)
         {
            this.FOverlayerMonster.Update();
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBackGroundBitmap,CONST_MODULES.MODULE_GroupBattle,this.FMapId);
         _loc2_ = this.FPlayerActive.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FPlayerActive[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_.UpdateActive();
            }
            _loc1_++;
         }
         _loc2_ = this.FMonsterActive.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMonsterActive[_loc1_].UpdateActive();
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GROUPBATTLE.RESOURCESID_Swf_GroupBattle);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIPlayerHead = null;
         var _loc2_:TUIHeroHead = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         this.FBackGroundComponent = new TUIComponent(this);
         this.FPlayerActive = new Vector.<TActive>(this.CAPACITY_PLAYERHEADS);
         this.FMonsterActive = new Vector.<TActive>(this.CAPACITY_MONSTERHEADS);
         this.FBackGroundBitmap = new Bitmap();
         this.FBackGroundComponent.addChild(this.FBackGroundBitmap);
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_GROUPBATTLE.RESOURCE_ClassName_MC_BattleReady) as Sprite;
         TGameUtil.AddWindowMask(this);
         UIDispatch();
         this.FMC_StartBattle = FMainUI["MC_StartBattle"];
         TGameUtil.setButtonMode(this.FMC_StartBattle,true);
         this.FTF_CountDown = this.FMC_StartBattle["TF_CountDown"];
         this.FTF_CountDown.text = STRING_GROUPBATTLE.STRING_StartBattle;
         _loc4_ = this.CAPACITY_PLAYERHEADS;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = new TUIPlayerHead(this);
            _loc1_.Resource = FMainUI["MC_Player_" + _loc3_];
            _loc1_.Tag = _loc3_;
            _loc1_.OnPress = this.ProcessorOnPress;
            _loc1_.OnRelease = this.ProcessorOnRelease;
            _loc1_.OnOver = this.UIComponentsPlayerTipOnOver;
            _loc1_.OnOut = this.UIComponentsPlayerTipOnOut;
            _loc1_.Init();
            this.FUIPlayerHeads[_loc3_] = _loc1_;
            _loc3_++;
         }
         _loc4_ = this.CAPACITY_MONSTERHEADS;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = new TUIHeroHead(this);
            _loc2_.Resource = FMainUI["MC_Monster_" + _loc3_];
            _loc2_.OnOver = this.UIComponentsPlayerTipOnOver;
            _loc2_.OnOut = this.UIComponentsPlayerTipOnOut;
            _loc2_.Init();
            this.FUIMonsterHeads[_loc3_] = _loc2_;
            _loc3_++;
         }
         this.FSelectHeroBitmap = new Bitmap();
         addChild(this.FSelectHeroBitmap);
         this.FSelectHeroDefault = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
         addChild(this.FSelectHeroDefault);
         this.FSelectHeroDefault.visible = false;
         this.FSelectHeroDefault.mouseEnabled = false;
         this.FOverlayerPlayer = new TOverlayerPlayer(this.Parent);
         this.FOverlayerPlayer.Resource = TUtilityReflection.CreateDisplayObjectInstance("MC_PlayerTip") as Sprite;
         this.FOverlayerPlayer.Perform_UIDispatch();
         this.FOverlayerPlayer.Visible = false;
         this.FOverlayerMonster = new TOverlayerMonster(this.Parent);
         this.FOverlayerMonster.Resource = TUtilityReflection.CreateDisplayObjectInstance("MC_MonsterTip") as Sprite;
         this.FOverlayerMonster.Perform_UIDispatch();
         this.FOverlayerMonster.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
         this.FMC_StartBattle.addEventListener(MouseEvent.CLICK,this.MCStartBattleOnClick,false,0,true);
         this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel) as TBins;
      }
      
      protected function UpdateUI() : void
      {
         this.UpdatePlayerHead();
         this.UpdateEnemyHead();
      }
      
      protected function UpdatePlayerHead() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIPlayerHead = null;
         var _loc4_:TRoomPlayer = null;
         _loc2_ = this.CAPACITY_PLAYERHEADS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIPlayerHeads[_loc1_];
            _loc4_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc1_);
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function GetMonsterInfo(param1:TMonsters) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TMonster = null;
         _loc3_ = uint(param1.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.GetMonsterByIndex(_loc2_);
            if(_loc4_.IsChar)
            {
               return _loc4_.Identifier;
            }
            _loc2_++;
         }
         return 0;
      }
      
      protected function UpdateEnemyHead() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:TMonsters = null;
         var _loc5_:TMonsterInfo = null;
         _loc5_ = this.FGroupBattleData.MonsterInfo;
         _loc2_ = this.CAPACITY_MONSTERHEADS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIMonsterHeads[_loc1_];
            _loc4_ = _loc5_.GetMonstersByIndex(_loc1_);
            _loc3_.Context = _loc4_;
            _loc1_++;
         }
      }
      
      protected function CheckMouseIcon() : void
      {
         var _loc1_:TRoleModel = null;
         var _loc2_:TCoordinate = null;
         if(this.FHero != null)
         {
            _loc1_ = this.FRoleModel.GetDatebaseByIdentifier(this.FHero.Identifier) as TRoleModel;
            _loc2_ = TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FSelectHeroBitmap,CONST_MODULES.MODULE_GroupBattle,_loc1_.Model);
            if(_loc2_ != null)
            {
               this.FShowHeroCoordinate = _loc2_;
            }
            if(this.FSelectHeroBitmap.bitmapData == null)
            {
               this.FSelectHeroDefault.visible = true;
               this.FSelectHeroDefault.x = mouseX;
               this.FSelectHeroDefault.y = mouseY;
               this.FSelectHeroDefault.alpha = 0.7;
            }
            else
            {
               this.FSelectHeroDefault.visible = false;
               this.FSelectHeroBitmap.x = mouseX;
               this.FSelectHeroBitmap.y = mouseY;
               this.FSelectHeroBitmap.alpha = 0.7;
               if(this.FShowHeroCoordinate != null)
               {
                  this.FSelectHeroBitmap.x -= this.FShowHeroCoordinate.X;
                  this.FSelectHeroBitmap.y -= this.FShowHeroCoordinate.Y;
               }
            }
         }
         else
         {
            if(this.FSelectHeroBitmap != null && this.FSelectHeroBitmap.bitmapData != null)
            {
               this.FSelectHeroBitmap.bitmapData = null;
            }
            if(this.FSelectHeroDefault != null)
            {
               this.FSelectHeroDefault.visible = false;
            }
         }
      }
      
      protected function ResetPlayerModel() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActive = null;
         _loc2_ = this.CAPACITY_PLAYERHEADS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FPlayerActive[_loc1_] != null)
            {
               _loc3_ = this.FPlayerActive[_loc1_];
               TPoolRole.SaveActive(_loc3_);
            }
            _loc1_++;
         }
         this.SetPlayerActive();
      }
      
      protected function SetPlayerActive() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TRoomPlayer = null;
         var _loc4_:TActive = null;
         if(this.FGroupBattleData == null)
         {
            return;
         }
         _loc2_ = this.CAPACITY_PLAYERHEADS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FGroupBattleData.RoomDetailInfo.RoomPlayers.GetRoomPlayerByIndex(_loc1_);
            if(_loc3_ != null)
            {
               _loc4_ = TPoolRole.GetActive(this.FBackGroundComponent,_loc3_.PlayerModelID,CONST_MODULES.MODULE_GroupBattle,true);
               _loc4_.x = 200;
               _loc4_.y = 300 + 120 * _loc1_;
               _loc4_.SetRoleName(_loc3_.PlayerName);
            }
            else
            {
               _loc4_ = null;
            }
            this.FPlayerActive[_loc1_] = _loc4_;
            _loc1_++;
         }
      }
      
      protected function SetEnemyActive() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TMonsters = null;
         var _loc4_:TMonsterInfo = null;
         var _loc5_:TActive = null;
         if(this.FGroupBattleData == null)
         {
            return;
         }
         _loc4_ = this.FGroupBattleData.MonsterInfo;
         _loc2_ = this.CAPACITY_MONSTERHEADS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetMonstersByIndex(_loc1_);
            if(_loc3_ != null)
            {
               _loc5_ = TPoolRole.GetActive(this.FBackGroundComponent,this.GetMonsterInfo(_loc3_),CONST_MODULES.MODULE_GroupBattle,true);
               _loc5_.direction = false;
               _loc5_.x = 1000 + _loc1_ % 2 * 100;
               _loc5_.y = 300 + int(_loc1_ / 2) * 120;
            }
            else
            {
               _loc5_ = null;
            }
            this.FMonsterActive[_loc1_] = _loc5_;
            _loc1_++;
         }
      }
      
      protected function ReleaseActive() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TActive = null;
         if(this.FPlayerActive != null)
         {
            _loc2_ = this.CAPACITY_PLAYERHEADS;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               TPoolRole.SaveActive(this.FPlayerActive[_loc1_]);
               _loc1_++;
            }
         }
         if(this.FMonsterActive != null)
         {
            _loc2_ = this.CAPACITY_MONSTERHEADS;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               TPoolRole.SaveActive(this.FMonsterActive[_loc1_]);
               _loc1_++;
            }
         }
      }
      
      protected function UIComponentsPlayerTipOnOver(param1:Object, param2:Object) : void
      {
         if(param2 is TMonsters)
         {
            this.FOverlayerMonster.Context = param2;
            this.FOverlayerMonster.Render(FUICore.MouseCoordinate);
            this.FOverlayerMonster.Show();
         }
         else if(param2 is TRoomPlayer)
         {
            this.FOverlayerPlayer.Context = param2;
            this.FOverlayerPlayer.Render(FUICore.MouseCoordinate);
            this.FOverlayerPlayer.Show();
         }
      }
      
      protected function UIComponentsPlayerTipOnOut(param1:Object, param2:Object) : void
      {
         if(param2 == null)
         {
            this.FOverlayerMonster.Hide();
            this.FOverlayerPlayer.Hide();
         }
         if(param2 is TMonsters)
         {
            this.FOverlayerMonster.Context = null;
            this.FOverlayerMonster.Hide();
         }
         else if(param2 is TRoomPlayer)
         {
            this.FOverlayerPlayer.Context = null;
            this.FOverlayerPlayer.Hide();
         }
      }
      
      protected function ProcessorOnPress(param1:Object, param2:Object, param3:int) : void
      {
         this.FHero = param2 as THero;
         this.FHeroTag = param3;
      }
      
      protected function ProcessorOnRelease(param1:Object, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2;
         if(this.FHeroTag != -1 && _loc3_ != -1 && this.FHeroTag != _loc3_)
         {
            if(this.FExchangePosition != null)
            {
               this.FExchangePosition(CONST_GROUPBATTLE.RoomOperateReq_ChangePosition,this.FHeroTag,_loc3_);
            }
         }
         this.FHero = null;
         this.CheckMouseIcon();
      }
      
      protected function MCStartBattleOnClick(param1:MouseEvent) : void
      {
         if(this.FGroupBattleData.RoomDetailInfo.SelfIndex != this.FGroupBattleData.RoomDetailInfo.HostIndex)
         {
            EffectGenerateText(STRING_GROUPBATTLE.STRING_NoOperating);
            return;
         }
         FMainUI.visible = false;
         if(this.FStartBattleOnClick != null)
         {
            this.FStartBattleOnClick(this);
         }
      }
      
      public function set StartBattleOnClick(param1:Function) : void
      {
         this.FStartBattleOnClick = param1;
      }
      
      public function set ExchangePosition(param1:Function) : void
      {
         this.FExchangePosition = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TLeagueMapPve = null;
         super.Visible = param1;
         if(this.FGroupBattleData != null)
         {
            _loc2_ = this.FGroupBattleData.RoomDetailInfo.MissionID;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,_loc2_) as TLeagueMapPve;
            if(_loc3_ != null)
            {
               this.FMapId = _loc3_.Map;
            }
         }
         if(param1)
         {
            if(FMainUI != null)
            {
               FMainUI.visible = true;
            }
            this.ReleaseActive();
            this.SetPlayerActive();
            this.SetEnemyActive();
            this.FEffDelayReferenceTick = STimingCore.GetServerTick() + 15;
            this.FIsAutoStart = true;
         }
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function UpdatePlayerPosition() : void
      {
         this.UpdatePlayerHead();
         this.ResetPlayerModel();
         this.FHero = null;
         this.CheckMouseIcon();
      }
   }
}

